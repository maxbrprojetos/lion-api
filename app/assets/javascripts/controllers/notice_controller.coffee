Notdvs.NoticeController = Ember.ObjectController.extend
  isRemoving: false

  actions:
    delete: ->
      @set('isRemoving', true)
      Ember.run.later(this, ->
        @get('model').destroyRecord()
      , 1000)
