Notdvs.NoticesController = Ember.ArrayController.extend(EmberPusher.Bindings,
  PUSHER_SUBSCRIPTIONS:
    notdvs: ['notice.create', 'notice.destroy']

  sortProperties: ['createdAt']
  sortAscending: false
  itemController: 'notice'
  title: ''

  actions:
    addNotice: ->
      newNotice = @store.createRecord('notice', { title: @get('title') })
      newNotice.save()

      @set('title', '')

    # pusher actions
    noticeCreate: (payload) ->
      @store.pushRecord('notice', payload.notice)

    noticeDestroy: (payload) ->
      if @store.hasRecordForId('notice', payload.notice.id)
        notice = @store.getById('notice', payload.notice.id)
        notice.unloadRecord() if notice != undefined && !notice.get('isDirty')
)