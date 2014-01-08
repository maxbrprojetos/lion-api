Notdvs.ApplicationRoute = Ember.Route.extend(Ember.SimpleAuth.ApplicationRouteMixin,
  actions:
    login: ->
      window.open(
        "#{location.protocol}//#{location.host}/auth/github", '_blank',
        'menubar=no,status=no,height=400,width=800'
      )
)