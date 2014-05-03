Ember.Pushable = (modelName) ->
  actions = {}

  actions["#{modelName}Create"] = (payload) ->
    @store.pushPayload(payload) unless @get('newRecords').anyBy('clientId', payload[modelName].client_id)

  actions["#{modelName}Update"] = (payload) ->
    @store.pushPayload(payload)

  actions["#{modelName}Destroy"] = (payload) ->
    model = @store.getById(modelName, payload[modelName].id)
    model.unloadRecord() if model != null && !model.get('isDirty')

  Ember.Mixin.create(EmberPusher.Bindings,
    PUSHER_SUBSCRIPTIONS:
      pusher: ["#{modelName}.create", "#{modelName}.update", "#{modelName}.destroy"]

    newRecords: Ember.A([])

    actions: actions
  )
