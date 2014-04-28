Lion.TaskRoute = Lion.AuthenticatedRoute.extend
  beforeModel: ->
    Ember.run.scheduleOnce('afterRender', this, =>
      taskItem = $(".#{@get('controller.id')}")[0]
      taskItem.scrollIntoView()
    )

  model: (params) ->
    @store.find('task', params.task_id)

  actions:
    close: ->
      @transitionTo('tasks')
