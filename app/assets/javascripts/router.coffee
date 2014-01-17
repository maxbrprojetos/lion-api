# For more information see: http://emberjs.com/guides/routing/

Notdvs.Router.map ->
  @resource('notices', path: '/')
  @route('login')
  @resource('tasks', ->
    @route('mine')
  )
