# For more information see: http://emberjs.com/guides/routing/

Lion.Router.reopen(
  location: 'history'
)

Lion.Router.map ->
  @route('login')
  @resource('tasks', path: '/', ->
    @route('mine')
  )
  @resource('leaderboard', ->
    @route('all-time')
    @route('weekly')
  )

