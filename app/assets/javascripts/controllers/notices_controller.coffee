Notdvs.NoticesController = Ember.ArrayController.extend(EmberPusher.Bindings,
  PUSHER_SUBSCRIPTIONS:
    notdvs: ['notice.create', 'notice.destroy']

  sortProperties: ['createdAt']
  sortAscending: false
  itemController: 'notice'
  title: ''

  actions:
    addNotice: ->
      newNotice = Notdvs.Notice.create(title: @get('title'))
      newNotice.save()

      @set('title', '')

    # pusher actions
    noticeCreate: (payload) ->
      Notdvs.Notice.loadOne(payload)

    noticeDestroy: (payload) ->
      notice = Notdvs.Notice.find(payload.notice.id)
      notice.unload() if notice != undefined
)