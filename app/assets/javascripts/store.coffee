Notdvs.Adapter = Ember.RESTAdapter.extend()

Notdvs.Model = Ember.Model.extend
  init: ->
    @_super.apply this, arguments
    this

  merge: (hash) ->
    data = @get('_data')
    Ember.merge(data, hash)
    @notifyPropertyChange('_data')

  unload: ->
    @constructor.unload(this)

  dataKey: (key) ->
    meta = @constructor.metaForProperty(key)
    if meta.isRelationship && !meta.options?.key?
      type = meta.type
      if typeof type == "string"
        type = Ember.get(Ember.lookup, type)

      if meta.kind == 'belongsTo'
        return type.singularName() + '_id'
      else
        return type.singularName() + '_ids'

    @_super(key)

  load: (id, hash) ->
    @loadedAttributes = []
    @loadedRelationships = []

    attributes = this.constructor.getAttributes() || []
    relationships = this.constructor.getRelationships() || []

    if hash
      for key in attributes
        dataKey = @dataKey(key)
        if hash.hasOwnProperty(dataKey)
          @loadedAttributes.pushObject(key)

      for key in relationships
        dataKey = @dataKey(key)
        if hash.hasOwnProperty(dataKey)
          @loadedRelationships.pushObject(key)

    incomplete = Ember.EnumerableUtils.intersection(@loadedAttributes, attributes).length != attributes.length ||
                 Ember.EnumerableUtils.intersection(@loadedRelationships, relationships).length != relationships.length

    #if incomplete
    #  properties = attributes.concat(relationships)
    #  loadedProperties = @loadedAttributes.concat(@loadedRelationships)
    #  diff = properties.diff(loadedProperties)
    #  #console.log(@constructor, 'with id', id, 'loaded as incomplete, info:', { diff: diff, attributes: loadedProperties, data: hash})

    @set('incomplete', incomplete)

    @_super(id, hash)

  getAttr: (key, options) ->
    @needsCompletionCheck(key)
    @_super.apply this, arguments

  getBelongsTo: (key, type, meta) ->
    unless key
      key = type.singularName() + '_id'
    @needsCompletionCheck(key)
    @_super(key, type, meta)

  getHasMany: (key, type, meta) ->
    unless key
      key = type.singularName() + '_ids'
    @needsCompletionCheck(key)
    @_super(key, type, meta)

  needsCompletionCheck: (key) ->
    if key && (@isAttribute(key) || @isRelationship(key)) &&
        @get('incomplete') && !@isPropertyLoaded(key)
      @loadTheRest(key)

  isAttribute: (name) ->
    this.constructor.getAttributes().contains(name)

  isRelationship: (name) ->
    this.constructor.getRelationships().contains(name)

  loadTheRest: (key) ->
    # for some weird reason key comes changed to a string and for some weird reason it even is called with
    # undefined key
    return if !key || key == 'undefined'

    message = "Load missing fields for #{@constructor.toString()} because of missing key '#{key}', cid: #{@get('clientId')}, id: #{@get('id')}"
    if @isAttribute('state') && key != 'state'
      message += ", in state: #{@get('state')}"
    console.log message
    return if @get('isCompleting')
    @set 'isCompleting', true

    @reload()

  select: ->
    @constructor.select(@get('id'))

  isPropertyLoaded: (name) ->
    @loadedAttributes.contains(name) || @loadedRelationships.contains(name)

Notdvs.Model.reopenClass
  loadOne: (json) ->
    root = @singularName()
    reference = @loadOrMerge(json[root])
    unless reference.record
      @loadRecordForReference(reference)

  loadOrMerge: (hash, options) ->
    options ||= {}

    reference = @_getReferenceById(hash.id)

    if reference && options.skipIfExists
      return

    reference = @_getOrCreateReferenceForId(hash.id)
    if reference.record
      reference.record.merge(hash)
    else
      if @sideloadedData && @sideloadedData[hash.id]
        Ember.merge(@sideloadedData[hash.id], hash)
      else
        @load([hash])

    reference

  select: (id) ->
    @find().forEach (record) ->
      record.set('selected', record.get('id') == id)

  buildURL: (suffix) ->
    base = @url || @pluralName()
    Ember.assert('Base URL (' + base + ') must not start with slash', !base || base.toString().charAt(0) != '/')
    Ember.assert('URL suffix (' + suffix + ') must not start with slash', !suffix || suffix.toString().charAt(0) != '/')
    url = [base]
    url.push(suffix) if (suffix != undefined)
    url.join('/')

  singularName: ->
    parts = @toString().split('.')
    name = parts[parts.length - 1]
    name.replace(/([A-Z])/g, '_$1').toLowerCase().slice(1)

  pluralName: ->
    @singularName() + 's'

  collectionKey: (->
    @pluralName()
  ).property()

  rootKey: (->
    @singularName()
  ).property()

  isModel: (->
    true
  ).property()

  isRecordLoaded: (id) ->
    reference = @_getReferenceById(id)
    reference && reference.record

  camelizeKeys: true

  # TODO: the functions below will be added to Ember Model, remove them when that
  # happens
  resetData: ->
    @_referenceCache = {}
    @sideloadedData = {}
    @recordArrays = []
    @_currentBatchIds = []
    @_hasManyArrays = []
    @_findAllRecordArray = null

  unload: (record) ->
    @removeFromRecordArrays(record)
    primaryKey = record.get(Ember.get(this, 'primaryKey'))
    @removeFromCache(primaryKey)

  removeFromCache: (key) ->
    if @sideloadedData && @sideloadedData[key]
      delete this.sideloadedData[key]
    if @recordCache && @recordCache[key]
      delete this.recordCache[key]

  loadRecordForReference: (reference) ->
    record = @create({ _reference: reference, id: reference.id })
    @sideloadedData = {} unless @sideloadedData
    reference.record = record
    record.load(reference.id, @sideloadedData[reference.id])
    # TODO: find a nicer way to not add record to record arrays twice
    if @currentRecordsToAdd
      @currentRecordsToAdd.pushObject(record) unless @currentRecordsToAdd.contains(record)
    else
      @currentRecordsToAdd = [record]

    Ember.run.scheduleOnce('data', this, @_batchAddToRecordArrays);

  _batchAddToRecordArrays: ->
    for record in @currentRecordsToAdd
      if !@_findAllRecordArray || !@_findAllRecordArray.contains(record)
        @addToRecordArrays(record)

    @currentRecordsToAdd = null

Ember.RecordArray.reopen
  # TODO: ember.js changed a way ArrayProxies behave, so that check for content is done
  #       in _replace method. I should not be overriding it, because it's private, but
  #       there is no easy other way to do it at this point
  _replace: (index, removedCount, records) ->
    # in Notdvs it's sometimes the case that we add new records to RecordArrays
    # from pusher before its content has loaded from an ajax query. In order to handle
    # this case nicer I'm extending record array to buffer those records and push them
    # to content when it's available
    @bufferedRecords = [] unless @bufferedRecords

    if !@get('content')
      for record in records
        @bufferedRecords.pushObject(record) unless @bufferedRecords.contains(record)

      records = []

    # call super only if there's anything more to add
    if removedCount || records.length
      @_super(index, removedCount, records)

  contentDidChange: (->
    if (content = @get('content')) && @bufferedRecords && @bufferedRecords.length
      for record in @bufferedRecords
        content.pushObject(record) unless content.contains(record)
      @bufferedRecords = []
  ).observes('content')