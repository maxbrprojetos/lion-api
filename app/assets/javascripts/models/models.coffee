Notdvs.Notice = Notdvs.Model.extend
  title: DS.attr('string')
  type: DS.attr('string', { defaultValue: 'warning' })
  app: DS.attr('string', { defaultValue: 'pistachio' })

  ranking: (->
    # check createdAt first so records coming from pusher cannot alter ordering
    # by providing a different kind of clientId
    @get('createdAt')?.getTime().toString() || @get('clientId')
  ).property('clientId', 'createdAt')

Notdvs.Task = Notdvs.Model.extend
  title: DS.attr('string')
  completed: DS.attr('boolean', { defaultValue: false })
  user: DS.belongsTo('user')

Notdvs.User = DS.Model.extend
  nickname: DS.attr('string')
  avatar_url: DS.attr('string')