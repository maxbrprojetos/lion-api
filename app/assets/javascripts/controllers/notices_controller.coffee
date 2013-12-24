App.NoticesController = Ember.ArrayController.extend
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