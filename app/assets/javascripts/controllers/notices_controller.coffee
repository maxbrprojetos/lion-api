App.NoticesController = Ember.ArrayController.extend
  itemController: 'notice'
  title: ''

  actions:
    addNotice: ->
      newNoticeReference = new Firebase('https://notdvs.firebaseio.com/notices/pistachio').push()
      newNotice = EmberFire.Object.create(ref: newNoticeReference)
      newNotice.setProperties(
        id: newNoticeReference.name()
        title: @get('title')
        timestamp: new Date()
      )

      @set('title', '')

    deleteNotice: (notice) ->
      @get('content').removeObject(notice)