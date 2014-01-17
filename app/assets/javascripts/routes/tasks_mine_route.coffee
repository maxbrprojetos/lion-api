Notdvs.TasksMineRoute = Ember.Route.extend(
  setupController: ->
    tasks = @store.filter('task', (task) =>
      task.get('user.id') == @get('session.currentUser.id')
    )

    @controllerFor('tasks').set('filteredTasks', tasks)
)