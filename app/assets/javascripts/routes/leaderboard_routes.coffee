Lion.LeaderboardIndexRoute = Lion.AuthenticatedRoute.extend
  beforeModel: (transition) ->
    @transitionTo('leaderboard.weekly')
    @_super(transition)

Lion.LeaderboardAllTimeRoute = Lion.AuthenticatedRoute.extend
  setupController: ->
    @_super.apply(this, arguments)

    @store.find('score', { time_span: 'all_time' }).then((scores) =>
      @controllerFor('leaderboard').set('content', scores)
    )

Lion.LeaderboardWeeklyRoute = Lion.AuthenticatedRoute.extend
  setupController: ->
    @_super.apply(this, arguments)

    @store.find('score', { time_span: 'weekly' }).then((scores) =>
      @controllerFor('leaderboard').set('content', scores)
    )
