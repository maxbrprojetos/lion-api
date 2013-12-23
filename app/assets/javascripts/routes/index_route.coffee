App.IndexRoute = Ember.Route.extend
  setupController: (controller) ->
    controller.set('notices', EmberFire.Array.create(ref: new Firebase('https://notdvs.firebaseio.com/notices/pistachio')))