App.NoticesController = Ember.ArrayController.extend(EmberPusher.Bindings,
  PUSHER_SUBSCRIPTIONS:
    notdvs: ['notice.create', 'notice.destroy']

  sortProperties: ['created_at']
  sortAscending: false
  itemController: 'notice'
  title: ''

  actions:
    addNotice: ->
      newNotice = App.Notice.create(title: @get('title'))
      newNotice.save().then((notice) =>
        App.Notice.unload(notice) # let Pusher do the insertion
      )

      @set('title', '')

    # pusher actions
    noticeCreate: (payload) ->
      notice = App.Notice.create(payload['notice'])
      @get('content').pushObject(notice)

    noticeDestroy: (payload) ->
      notice = App.Notice.getFromRecordCache(payload['notice']['id'])
      App.Notice.unload(notice)
)