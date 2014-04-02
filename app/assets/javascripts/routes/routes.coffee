Notdvs.LoadingRoute = Ember.Route.extend(
  activate: ->
    @_super.apply(this, arguments)
    Pace.restart()

  deactivate: ->
    @_super.apply(this, arguments)
    Pace.stop()
)

Notdvs.LoginRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo(Ember.SimpleAuth.routeAfterLogin) if @get('session.isAuthenticated')

  setupController: ->
    @controllerFor('application').connectLayout('simple')

Notdvs.TasksRoute = Notdvs.AuthenticatedRoute.extend
  beforeModel: (transition) ->
    Notify.prototype.requestPermission() if Notify.prototype.isSupported() && Notify.prototype.needsPermission()

    @store.find('user').then((users) =>
      @controllerFor('tasks').set('users', users)
    )

    @_super(transition)

  model: ->
    @store.find('task')

Notdvs.TasksIndexRoute = Notdvs.AuthenticatedRoute.extend
  setupController: ->
    @controllerFor('tasks').set('filteredTasks', @modelFor('tasks'))

Notdvs.TasksMineRoute = Notdvs.AuthenticatedRoute.extend
  setupController: ->
    tasks = @store.filter('task', (task) =>
      currentUserId = @controllerFor('currentUser').get('content.id')

      if !Ember.isEmpty(task.get('assignee'))
        task.get('assignee.id') == currentUserId
      else
        task.get('user.id') == currentUserId
    )

    @controllerFor('tasks').set('filteredTasks', tasks)

Notdvs.LeaderboardIndexRoute = Notdvs.AuthenticatedRoute.extend
  beforeModel: ->
    @transitionTo('leaderboard.weekly')

Notdvs.LeaderboardAllTimeRoute = Notdvs.AuthenticatedRoute.extend
  setupController: ->
    @controllerFor('leaderboard').set('content', @store.find('score', { time_span: 'all_time' }))

Notdvs.LeaderboardWeeklyRoute = Notdvs.AuthenticatedRoute.extend
  setupController: ->
    @controllerFor('leaderboard').set('content', @store.find('score', { time_span: 'weekly' }))

