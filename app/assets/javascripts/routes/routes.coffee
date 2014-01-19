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
      currentUserId = @get('session.currentUser.id')
      task.get('user.id') == currentUserId || task.get('assignee.id') == currentUserId
    )

    @controllerFor('tasks').set('filteredTasks', tasks)
)