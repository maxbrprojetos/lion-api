Notdvs.IndexRoute = Ember.Route.extend
  model: ->
    @store.find('notice')

  setupController: (controller, model) ->
    controller.set('notices', model)