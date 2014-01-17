Notdvs.Pusherable = (modelName) ->
  actions = {}

  actions["#{modelName}Create"] = (payload) ->
    @store.pushRecord(modelName, payload[modelName]) unless @get('newRecords').anyBy('client_id', payload[modelName].client_id)

  actions["#{modelName}Update"] = (payload) ->
    @store.pushRecord(modelName, payload[modelName])

  actions["#{modelName}Destroy"] = (payload) ->
    model = @store.getById(modelName, payload[modelName].id)
    model.unloadRecord() if model != null && !model.get('isDirty')

  Ember.Mixin.create(EmberPusher.Bindings,
    PUSHER_SUBSCRIPTIONS:
      notdvs: ["#{modelName}.create", "#{modelName}.update", "#{modelName}.destroy"]

    newRecords: Ember.A([])

    actions: actions
  )