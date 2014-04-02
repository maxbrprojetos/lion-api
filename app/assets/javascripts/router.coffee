# For more information see: http://emberjs.com/guides/routing/

Notdvs.Router.reopen(
  location: 'history'
)

Notdvs.Router.map ->
  @route('login')
  @resource('tasks', path: '/', ->
    @route('mine')
  )
  @resource('leaderboard', ->
    @route('all-time')
    @route('weekly')
  )

