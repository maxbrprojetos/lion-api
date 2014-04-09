Lion.AuthenticatedRoute = Ember.Route.extend(Ember.SimpleAuth.AuthenticatedRouteMixin,
  setupController: ->
    @_super.apply(this, arguments)
    @controllerFor('application').connectLayout('application')
)
