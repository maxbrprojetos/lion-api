Lion.LoadingRoute = Ember.Route.extend(
  activate: ->
    @_super.apply(this, arguments)
    Pace.restart()

  deactivate: ->
    @_super.apply(this, arguments)
    Pace.stop()
)
