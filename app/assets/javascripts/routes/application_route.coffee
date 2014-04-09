Lion.ApplicationRoute = Ember.Route.extend(Ember.SimpleAuth.ApplicationRouteMixin,
  actions:
    signin: ->
      window.open(
        "#{location.protocol}//#{location.host}/auth/github", '_blank',
        'menubar=no,status=no,height=400,width=800'
      )

    loginSucceeded: ->
      # move this inside the ajax promise resolution
      @_super.apply(this, arguments)
      @get('session').login()

    logout: ->
      @get('session').logout()
      @_super.apply(this, arguments)
)
