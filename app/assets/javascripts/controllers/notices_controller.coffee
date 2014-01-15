Notdvs.NoticesController = Ember.ArrayController.extend(EmberPusher.Bindings,
  PUSHER_SUBSCRIPTIONS:
    notdvs: ['notice.create', 'notice.destroy']

  sortProperties: ['ranking']
  sortAscending: false
  title: ''
  itemController: 'notice'
  newNotices: Ember.A([])

  failingApplications: (->
    @get('content').mapBy('app').uniq()
  ).property('content.@each.app')

  status: (->
    notices = @get('content')

    if notices.anyBy('type', 'warning')
      'warning'
    else if notices.anyBy('type', 'error')
      'error'
    else
      'ok'
  ).property('content.@each.type')

  statusMessage: (->
    failingApplicationsCount = @get('failingApplications.length')

    if failingApplicationsCount == 1
      @get('failingApplications.firstObject')
    else if failingApplicationsCount > 1
      "#{failingApplicationsCount} apps"
    else
      'ok'
  ).property('failingApplications.@each')

  actions:
    addNotice: ->
      input = new Notdvs.NoticeInput(@get('title'))
      noticeAttributes = {
        title: input.title(),
        client_id: (new Date()).getTime().toString()
      }

      $.extend(noticeAttributes, app: input.app()) if input.app().length > 0

      newNotice = @store.createRecord('notice', noticeAttributes)

      @get('newNotices').pushObject(newNotice)
      newNotice.save()

      @set('title', '')

    #### pusher actions

    noticeCreate: (payload) ->
      @store.pushRecord('notice', payload.notice) unless @get('newNotices').anyBy('client_id', payload.notice.client_id)

    noticeDestroy: (payload) ->
      notice = @store.getById('notice', payload.notice.id)
      notice.unloadRecord() if notice != null && !notice.get('isDirty')
)
