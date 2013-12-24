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
      newNotice.save()

      @set('title', '')

    deleteNotice: (notice) ->
      notice.deleteRecord()

    # pusher actions
    noticeCreate: (payload) ->
      notice = @findBy('id', payload['notice']['id'])
      @pushObject(App.Notice.create(payload['notice'])) unless notice?

    noticeDestroy: (payload) ->
      notice = @findBy('id', payload['notice']['id'])
      @removeObject(notice)
)