Lion.ApplicationRoute = Ember.Route.extend(Ember.SimpleAuth.ApplicationRouteMixin,
  actions:
    authenticateSession: ->
      @get('session').authenticate('authenticator:omniauth')

    sessionAuthenticationSucceeded: ->
      @_super.apply(this, arguments)
      @get('session').login()

    sessionInvalidationSucceeded: ->
      @get('session').logout()
      @_super.apply(this, arguments)
)
