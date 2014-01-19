Notdvs.NoticesController = Ember.ArrayController.extend(new Notdvs.Pusherable('notice'),
  sortProperties: ['createdAt']
  sortAscending: false
  title: ''
  itemController: 'notice'

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
    createNotice: ->
      input = new Notdvs.NoticeInput(@get('title'))
      noticeAttributes = {
        title: input.title(),
        clientId: (new Date()).getTime().toString()
      }

      $.extend(noticeAttributes, app: input.app()) if input.app().length > 0

      newNotice = @store.createRecord('notice', noticeAttributes)

      @get('newRecords').pushObject(newNotice)
      newNotice.save()

      @set('title', '')
)
