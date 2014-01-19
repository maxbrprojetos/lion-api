Notdvs.ApplicationView = Ember.View.extend
  templateName: (->
    @get('controller.layoutName')
  ).property('controller.layoutName')

  templateNameDidChange: (->
    @rerender()
  ).observes('templateName')

