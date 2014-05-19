Lion.TaskRoute = Lion.AuthenticatedRoute.extend
  beforeModel: (transition) ->
    Ember.run.scheduleOnce('afterRender', this, =>
      taskItem = $(".#{@get('controller.id')}")
      taskItem[0].scrollIntoView() unless taskItem.isVisible()
    )

    @_super(transition)

  model: (params) ->
    @store.find('task', params.task_id)
