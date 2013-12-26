Notdvs.IndexRoute = Ember.Route.extend
  model: ->
    Notdvs.Notice.fetchAll()

  setupController: (controller, model) ->
    controller.set('notices', model)