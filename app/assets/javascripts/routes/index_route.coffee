App.IndexRoute = Ember.Route.extend
  model: ->
    App.Notice.fetchAll()

  setupController: (controller, model) ->
    controller.set('notices', model)