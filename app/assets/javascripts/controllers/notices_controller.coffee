Notdvs.NoticesController = Ember.ArrayController.extend(EmberPusher.Bindings,
  PUSHER_SUBSCRIPTIONS:
    notdvs: ['notice.create', 'notice.destroy']

  sortProperties: ['created_at']
  sortAscending: false
  title: ''
  itemController: 'notice'
  newNotice: Ember.Object.create()

  actions:
    addNotice: ->
      newNotice = @store.createRecord('notice', {
        title: @get('title'),
        client_id: (new Date()).getTime().toString()
      })

      @set('newNotice', newNotice)
      newNotice.save()

      @set('title', '')

    # pusher actions
    noticeCreate: (payload) ->
      @store.pushRecord('notice', payload.notice) unless payload.notice.client_id == @get('newNotice.client_id')

    noticeDestroy: (payload) ->
      notice = @store.getById('notice', payload.notice.id)
      notice.unloadRecord() if notice != null && !notice.get('isDirty')
)