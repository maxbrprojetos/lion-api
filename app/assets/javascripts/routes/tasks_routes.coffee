Lion.TasksRoute = Lion.AuthenticatedRoute.extend
  beforeModel: (transition) ->
    Notify.prototype.requestPermission() if Notify.prototype.isSupported() && Notify.prototype.needsPermission()

    @store.find('user').then((users) =>
      @controllerFor('tasks').set('users', users)
    )

    @_super(transition)

  setupController: (controller, model) ->
    @_super.apply(this, arguments)
    controller.set('filteredTasks', model)

  model: ->
    @store.find('task')

Lion.TasksIndexRoute = Lion.AuthenticatedRoute.extend
  setupController: ->
    @controllerFor('tasks').set('filteredTasks', @modelFor('tasks'))

Lion.TasksMineRoute = Lion.AuthenticatedRoute.extend
  setupController: ->
    tasks = @store.filter('task', (task) =>
      currentUserId = @controllerFor('currentUser').get('content.id')

      if !Ember.isEmpty(task.get('assignee'))
        task.get('assignee.id') == currentUserId
      else
        task.get('user.id') == currentUserId
    )

    @controllerFor('tasks').set('filteredTasks', tasks)
