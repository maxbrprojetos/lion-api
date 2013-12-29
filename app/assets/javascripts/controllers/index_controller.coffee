Notdvs.IndexController = Ember.ArrayController.extend
  notices: Ember.A()
  status: (->
    notices = @get('notices')

    if notices.anyBy('type', 'warning')
      'warning'
    else if notices.anyBy('type', 'error')
      'error'
    else
      'ok'
  ).property('notices.@each.type')