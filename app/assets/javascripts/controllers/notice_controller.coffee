Notdvs.NoticeController = Ember.ObjectController.extend
  actions:
    delete: ->
      @get('model').destroyRecord()
