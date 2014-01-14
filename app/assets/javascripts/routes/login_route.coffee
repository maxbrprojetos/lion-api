Notdvs.LoginRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo(Ember.SimpleAuth.routeAfterLogin) if @get('session.isAuthenticated')

  setupController: ->
    @controllerFor('application').connectLayout('simple')