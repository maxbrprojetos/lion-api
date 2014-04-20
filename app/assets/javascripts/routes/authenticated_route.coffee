Lion.AuthenticatedRoute = Ember.Route.extend(Ember.SimpleAuth.AuthenticatedRouteMixin,
  beforeModel: (transition) ->
    if !@get('session.isAuthenticated')
      transition.abort()
      @set('session.attemptedTransition', transition)
      @transitionTo('login')

  setupController: ->
    @_super.apply(this, arguments)
    @controllerFor('application').connectLayout('application')
)
