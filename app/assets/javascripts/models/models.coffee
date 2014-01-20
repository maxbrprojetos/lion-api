Notdvs.Notice = Notdvs.Model.extend
  title: DS.attr('string')
  type: DS.attr('string', { defaultValue: 'warning' })
  app: DS.attr('string', { defaultValue: 'pistachio' })

Notdvs.Task = Notdvs.Model.extend
  title: DS.attr('string')
  completed: DS.attr('boolean', { defaultValue: false })
  user: DS.belongsTo('user')
  assignee: DS.belongsTo('user')

  didUpdate: ->
    if Notdvs.get('currentUser.id') == @get('assignee.id')
      new Notify('You have been assigned an issue', { body: @get('title') }).show()

Notdvs.User = DS.Model.extend
  nickname: DS.attr('string')
  avatarUrl: DS.attr('string')