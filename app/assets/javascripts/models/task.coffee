Notdvs.Task = Notdvs.Model.extend
  title: DS.attr('string')
  completed: DS.attr('boolean', { defaultValue: false })
  user: DS.belongsTo('user')