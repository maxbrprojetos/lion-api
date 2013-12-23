App.NoticesController = Ember.ArrayController.extend
  itemController: 'notice'
  title: ''

  sortedNotices: Ember.computed.sort('content', (a, b) ->
    # EmberFire doesn't always wrap objects in Ember.Object
    a = Ember.Object.create(a)
    b = Ember.Object.create(b)

    if a.get('id') > b.get('id')
      return -1
    else if a.get('id') < b.get('id')
      return 1

    return 0
  )

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