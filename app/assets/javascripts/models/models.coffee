Notdvs.Notice = Notdvs.Model.extend
  title: DS.attr('string')
  type: DS.attr('string', { defaultValue: 'warning' })
  app: DS.attr('string', { defaultValue: 'pistachio' })

Notdvs.User = DS.Model.extend
  nickname: DS.attr('string')
  avatarUrl: DS.attr('string')

  githubUrl: (->
    "https://github.com/#{@get('nickname')}"
  ).property('nickname')

Notdvs.TaskCompletion = DS.Model.extend
  user: DS.belongsTo('user')
  task: DS.belongsTo('task')

Notdvs.Score = DS.Model.extend
  points: DS.attr('number')
  user: DS.belongsTo('user')

Notdvs.Comment = Notdvs.Model.extend
  body: DS.attr('string')
  user: DS.belongsTo('user')
  task: DS.belongsTo('task')
