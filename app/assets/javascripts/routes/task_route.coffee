Lion.TaskRoute = Lion.AuthenticatedRoute.extend
  model: (params) ->
    @store.find('task', params.task_id)

  actions:
    close: ->
      @transitionTo('tasks')
