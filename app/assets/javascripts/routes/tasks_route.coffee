Notdvs.TasksRoute = Notdvs.AuthenticatedRoute.extend
  model: ->
    @store.find('task')