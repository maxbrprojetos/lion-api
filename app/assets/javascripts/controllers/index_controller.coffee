App.IndexController = Ember.ArrayController.extend
  notices: Ember.A()
  isEverythingOk: Ember.computed.equal('notices.length', 0)