# For more information see: http://emberjs.com/guides/routing/

Notdvs.Router.map ->
  @route('signin')
  @resource('notices', path: '/')
  @resource('batcave')

