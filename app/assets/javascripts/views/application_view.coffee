Notdvs.ApplicationView = Ember.View.extend
  templateName: (->
    @get('controller.layoutName')
  ).property('controller.layoutName')

  templateNameDidChange: (->
    @rerender()
  ).observes('templateName')

  didInsertElement: ->
    @_super.apply(this, arguments)
    Ember.run.scheduleOnce('afterRender', this, @didRenderElement)

  didRenderElement: ->
    $(document).foundation()

