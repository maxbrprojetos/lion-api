Notdvs.NoticeController = Ember.ObjectController.extend
  isRemoving: false

  actions:
    delete: ->
      @set('isRemoving', true)
      Ember.run.later(this, ->
        @get('content').deleteRecord()
      , 1000)
