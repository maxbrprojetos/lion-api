Lion.Editable = Ember.Mixin.create
  init: ->
    @_super()

    bufferedField = 'buffered' + @get('editableField').capitalize()
    @set('bufferedField', bufferedField)

    Ember.defineProperty(this, bufferedField,
      Ember.computed.oneWay(@get('editableField'))
    )

  actions:
    toggleEditing: ->
      @set('isEditing', !@get('isEditing'))

    edit: ->
      @set('isEditing', true)

    doneEditing: ->
      bufferedField = @get(@get('bufferedField')).trim()

      if Ember.isEmpty(bufferedField)
        @remove()
      else
        model = @get('model')
        field = model.get(@get('editableField'))

        if field != bufferedField
          model.set(@get('editableField'), bufferedField)
          model.save()

        @set(@get('bufferedField'), bufferedField)
        @set('isEditing', false)

    cancelEditing: ->
      @set(@get('bufferedField'), @get(@get('editableField')))
      @set('isEditing', false)



