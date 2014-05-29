Lion.TasksRoute = Lion.AuthenticatedRoute.extend
  beforeModel: (transition) ->
    Notify.prototype.requestPermission() if Notify.prototype.isSupported() && Notify.prototype.needsPermission()

    @store.find('user').then((users) =>
      @controllerFor('tasks').set('users', users)
    )

    @_super(transition)

  model: ->
    @store.find('task')
