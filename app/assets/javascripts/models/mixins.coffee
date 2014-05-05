DS.PushableModel = Ember.Mixin.create
  clientId: DS.attr('string', defaultValue: -> new Date().getTime().toString())

DS.CreatableModel = Ember.Mixin.create
  createdAt: DS.attr('date', defaultValue: -> new Date())
