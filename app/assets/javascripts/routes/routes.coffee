Notdvs.LoginRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo(Ember.SimpleAuth.routeAfterLogin) if @get('session.isAuthenticated')

  setupController: ->
    @controllerFor('application').connectLayout('simple')

Notdvs.NoticesRoute = Notdvs.AuthenticatedRoute.extend
  model: ->
    @store.find('notice')

Notdvs.TasksRoute = Notdvs.AuthenticatedRoute.extend
  beforeModel: (transition) ->
    Notify.prototype.requestPermission() if Notify.prototype.needsPermission()

    @store.find('user').then((users) =>
      @controllerFor('tasks').set('users', users)
    )

    @_super(transition)

  model: ->
    @store.find('task')

Notdvs.TasksIndexRoute = Ember.Route.extend
  setupController: ->
    @controllerFor('tasks').set('filteredTasks', @modelFor('tasks'))

Notdvs.TasksMineRoute = Ember.Route.extend(
  setupController: ->
    tasks = @store.filter('task', (task) =>
      currentUserId = Notdvs.get('currentUser.id')

      if !Ember.isEmpty(task.get('assignee'))
        task.get('assignee.id') == currentUserId
      else
        task.get('user.id') == currentUserId
    )

    @controllerFor('tasks').set('filteredTasks', tasks)
)