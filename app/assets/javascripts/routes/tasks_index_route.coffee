Notdvs.TasksIndexRoute = Ember.Route.extend
  setupController: ->
    @controllerFor('tasks').set('filteredTasks', @modelFor('tasks'));
