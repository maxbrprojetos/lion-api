# For more information see: http://emberjs.com/guides/routing/

Lion.Router.reopen(
  location: 'history'
)

Lion.Router.map ->
  @route('login')
  @resource('tasks', ->
    @route('mine')
    @resource('task', path: ':task_id')
  )
  @resource('leaderboard', ->
    @route('all-time')
    @route('weekly')
  )
  @route('hall-of-fame')
  @route('stats')
  @route('badges')

