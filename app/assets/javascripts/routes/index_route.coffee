App.IndexRoute = Ember.Route.extend
  setupController: (controller) ->
    controller.set('notices', App.Notice.find())