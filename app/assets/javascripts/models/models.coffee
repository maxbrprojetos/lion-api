Notdvs.Notice = Notdvs.Model.extend
  title: DS.attr('string')
  type: DS.attr('string', { defaultValue: 'warning' })
  app: DS.attr('string', { defaultValue: 'pistachio' })

Notdvs.Task = Notdvs.Model.extend
  title: DS.attr('string')
  completed: DS.attr('boolean', { defaultValue: false })
  user: DS.belongsTo('user')
  assignee: DS.belongsTo('user')

  toggleCompleted: ->
    @set('completed', !@get('completed'))

    verb = if @get('completed') == true then 'POST' else 'DELETE'

    $.ajax(
      type: verb,
      url: '/api/completions',
      dataType: 'json',
      contentType: 'application/json; charset=utf-8',
      data: JSON.stringify({
        completable: {
          id: @get('id'),
          type: 'Task'
        }
      })
    ).then((data) =>
      Ember.run => @store.pushPayload(data)
    )

Notdvs.User = DS.Model.extend
  nickname: DS.attr('string')
  avatarUrl: DS.attr('string')

  githubUrl: (->
    "https://github.com/#{@get('nickname')}"
  ).property('nickname')
