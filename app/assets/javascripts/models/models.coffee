Notdvs.Notice = Notdvs.Model.extend
  title: DS.attr('string')
  type: DS.attr('string', { defaultValue: 'warning' })
  app: DS.attr('string', { defaultValue: 'pistachio' })

Notdvs.User = DS.Model.extend
  nickname: DS.attr('string')
  avatarUrl: DS.attr('string')
  points: DS.attr('number')

  githubUrl: (->
    "https://github.com/#{@get('nickname')}"
  ).property('nickname')

Notdvs.TaskCompletion = DS.Model.extend
  user: DS.belongsTo('user')
  task: DS.belongsTo('task')
