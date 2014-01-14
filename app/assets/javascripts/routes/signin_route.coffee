Notdvs.SigninRoute = Ember.Route.extend
  setupController: ->
    @container.lookup('controller:application').connectLayout('simple')