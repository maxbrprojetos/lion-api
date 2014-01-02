Notdvs.NoticesRoute = Ember.Route.extend
  model: ->
    @store.find('notice')