# For more information see: http://emberjs.com/guides/routing/

Notdvs.Router.reopen(
  location: 'history'
)

Notdvs.Router.map ->
  @resource('notices', path: '/')
  @route('login')
  @resource('tasks', ->
    @route('mine')
  )
  @route('leaderboard')
