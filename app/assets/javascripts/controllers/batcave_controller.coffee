Notdvs.BatcaveController = Ember.ArrayController.extend(EmberPusher.Bindings,
  PUSHER_SUBSCRIPTIONS:
    notdvs: ['task.create']

  newTasks: Ember.A([])

  actions:
    taskCreate: (payload) ->
      @store.pushRecord('task', payload.task) unless @get('newTasks').anyBy('client_id', payload.task.client_id)
)