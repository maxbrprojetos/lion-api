Notdvs.TodosMineRoute = Ember.Route.extend(
  setupController: ->
    tasks = @store.filter('task', (task) ->
      !task.get('mine')
    )

    @controllerFor('tasks').set('filteredTasks', tasks)
)