Lion.IndexRoute = Lion.AuthenticatedRoute.extend
  beforeModel: ->
    @transitionTo('tasks')
