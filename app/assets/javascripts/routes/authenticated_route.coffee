Notdvs.AuthenticatedRoute = Ember.Route.extend(Ember.SimpleAuth.AuthenticatedRouteMixin,
  setupController: ->
    @controllerFor('application').connectLayout('application')
)