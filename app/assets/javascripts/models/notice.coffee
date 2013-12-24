App.Notice = Ember.Model.extend
  id: Ember.attr()
  title: Ember.attr()
  created_at: Ember.attr(Date)

App.Notice.adapter = App.ApplicationAdapter.create()
App.Notice.url = 'api/notices'
App.Notice.collectionKey = 'notices'
App.Notice.rootKey = 'notice'