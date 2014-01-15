# For more information see: http://emberjs.com/guides/routing/

Notdvs.Router.map ->
  @route('login')
  @resource('notices', path: '/')
  @resource('batcave')

