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

  statusMessage: (->
    app = @get('content.firstObject.app')
    if app?.length > 0
      app
    else
      'All is ok'
  ).property('content.firstObject.app')

  actions:
    addNotice: ->
      input = new NoticeInput(@get('title'))
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

    ####

    _extract_app_from: (text) ->
      text.g
)

class NoticeInput
  regexp: /app:(.*)\s/

  constructor: (@input) ->

  title: ->
    @input.replace(@regexp, '')

  app: ->
    if @regexp.test(@input)
      $.trim(@regexp.exec(@input)[1])
    else
      ''
