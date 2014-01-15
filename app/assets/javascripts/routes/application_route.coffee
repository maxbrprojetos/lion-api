Notdvs.ApplicationRoute = Ember.Route.extend(Ember.SimpleAuth.ApplicationRouteMixin,
  actions:
    signin: ->
      window.open(
        "#{location.protocol}//#{location.host}/auth/github", '_blank',
        'menubar=no,status=no,height=400,width=800'
      )

    loginSucceeded: ->
      _super = @_super.bind(this)
      _login = @get('session').login.bind(this)

      $.getJSON("#{location.protocol}//#{location.host}/api/users/me").then((data) ->
        _super()
        _login(data.user)
      )
)