DS.Creatable = Ember.Mixin.create
  createdAt: DS.attr('date', defaultValue: -> new Date())
