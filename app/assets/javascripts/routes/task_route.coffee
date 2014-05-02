Lion.TaskRoute = Lion.AuthenticatedRoute.extend
  beforeModel: (transition) ->
    Ember.run.scheduleOnce('afterRender', this, =>
      taskItem = $(".#{@get('controller.id')}")[0]
      taskItem.scrollIntoView()
    )

    @_super(transition)

  model: (params) ->
    @store.find('task', params.task_id)
