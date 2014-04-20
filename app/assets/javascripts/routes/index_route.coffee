Lion.IndexRoute = Lion.AuthenticatedRoute.extend
  beforeModel: (transition) ->
    @transitionTo('tasks')
    @_super(transition)
