Notdvs.Notice = Notdvs.Model.extend
  title: DS.attr('string')
  type: DS.attr('string', { defaultValue: 'warning' })
  app: DS.attr('string', { defaultValue: 'pistachio' })

  ranking: (->
    # check created_at first so records coming from pusher cannot alter ordering
    # by providing a different kind of client_id
    @get('created_at')?.getTime().toString() || @get('client_id')
  ).property('client_id', 'created_at')

Notdvs.Task = Notdvs.Model.extend
  title: DS.attr('string')
  completed: DS.attr('boolean', { defaultValue: false })
  user: DS.belongsTo('user')

Notdvs.User = DS.Model.extend
  nickname: DS.attr('string')
  avatar_url: DS.attr('string')