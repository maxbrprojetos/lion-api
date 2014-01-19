Notdvs.Notice = Notdvs.Model.extend
  title: DS.attr('string')
  type: DS.attr('string', { defaultValue: 'warning' })
  app: DS.attr('string', { defaultValue: 'pistachio' })

Notdvs.Task = Notdvs.Model.extend
  title: DS.attr('string')
  completed: DS.attr('boolean', { defaultValue: false })
  user: DS.belongsTo('user')
  assignee: DS.belongsTo('user')

Notdvs.User = DS.Model.extend
  nickname: DS.attr('string')
  avatarUrl: DS.attr('string')