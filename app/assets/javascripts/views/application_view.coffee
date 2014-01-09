Notdvs.ApplicationView = Ember.View.extend
  didInsertElement: ->
    @_super()
    Ember.run.scheduleOnce('afterRender', this, @didRenderElement)

  didRenderElement: ->
    $(document).foundation()