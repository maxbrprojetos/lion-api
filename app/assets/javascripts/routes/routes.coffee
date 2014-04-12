Lion.LoadingRoute = Ember.Route.extend(
  activate: ->
    @_super.apply(this, arguments)
    Pace.restart()

  deactivate: ->
    @_super.apply(this, arguments)
    Pace.stop()
)

Lion.LoginRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo(Ember.SimpleAuth.routeAfterLogin) if @get('session.isAuthenticated')

  setupController: ->
    @controllerFor('application').connectLayout('simple')

Lion.TasksRoute = Lion.AuthenticatedRoute.extend
  beforeModel: (transition) ->
    Notify.prototype.requestPermission() if Notify.prototype.isSupported() && Notify.prototype.needsPermission()

    @store.find('user').then((users) =>
      @controllerFor('tasks').set('users', users)
    )

    @_super(transition)

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

Lion.LeaderboardIndexRoute = Lion.AuthenticatedRoute.extend
  beforeModel: ->
    @transitionTo('leaderboard.weekly')

Lion.LeaderboardAllTimeRoute = Lion.AuthenticatedRoute.extend
  setupController: ->
    @controllerFor('leaderboard').set('content', @store.find('score', { time_span: 'all_time' }))

Lion.LeaderboardWeeklyRoute = Lion.AuthenticatedRoute.extend
  setupController: ->
    @controllerFor('leaderboard').set('content', @store.find('score', { time_span: 'weekly' }))

Lion.HallOfFameRoute = Lion.AuthenticatedRoute.extend
  model: ->
    @store.find('weeklyWinning')

