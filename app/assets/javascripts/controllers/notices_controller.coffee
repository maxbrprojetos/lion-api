Notdvs.NoticesController = Ember.ArrayController.extend(EmberPusher.Bindings,
  PUSHER_SUBSCRIPTIONS:
    notdvs: ['notice.create', 'notice.destroy']

  sortProperties: ['ranking']
  sortAscending: false
  title: ''
  itemController: 'notice'
  newNotices: Ember.A([])

  status: (->
    notices = @get('content')

    if notices.anyBy('type', 'warning')
      'warning'
    else if notices.anyBy('type', 'error')
      'error'
    else
      'ok'
  ).property('content.@each.type')

  actions:
    addNotice: ->
      newNotice = @store.createRecord('notice', {
        title: @get('title'),
        client_id: (new Date()).getTime().toString()
      })

      @get('newNotices').pushObject(newNotice)
      newNotice.save()

      @set('title', '')

    # pusher actions
    noticeCreate: (payload) ->
      @store.pushRecord('notice', payload.notice) unless @get('newNotices').anyBy('client_id', payload.notice.client_id)

    noticeDestroy: (payload) ->
      notice = @store.getById('notice', payload.notice.id)
      notice.unloadRecord() if notice != null && !notice.get('isDirty')
)