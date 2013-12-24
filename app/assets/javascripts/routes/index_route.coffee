App.IndexRoute = Ember.Route.extend
  model: ->
    App.Notice.fetch()

  setupController: (controller, model) ->
    controller.set('notices', model)