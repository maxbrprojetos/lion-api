Lion.LeaderboardIndexRoute = Lion.AuthenticatedRoute.extend
  beforeModel: ->
    @transitionTo('leaderboard.weekly')

Lion.LeaderboardAllTimeRoute = Lion.AuthenticatedRoute.extend
  setupController: ->
    @controllerFor('leaderboard').set('content', @store.find('score', { time_span: 'all_time' }))

Lion.LeaderboardWeeklyRoute = Lion.AuthenticatedRoute.extend
  setupController: ->
    @controllerFor('leaderboard').set('content', @store.find('score', { time_span: 'weekly' }))
