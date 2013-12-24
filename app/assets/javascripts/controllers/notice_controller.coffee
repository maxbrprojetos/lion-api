App.NoticeController = Ember.ObjectController.extend
  isRemoving: false

  actions:
    delete: ->
      @set('isRemoving', true)
      setTimeout(=>
        @get('content').deleteRecord()
      , 1000)
