App.IndexController = Ember.ArrayController.extend
  notices: Ember.A()
  isEverythingOk: Ember.computed.empty('notices')