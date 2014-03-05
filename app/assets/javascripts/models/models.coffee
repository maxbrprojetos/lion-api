Notdvs.Notice = Notdvs.Model.extend
  title: DS.attr('string')
  type: DS.attr('string', { defaultValue: 'warning' })
  app: DS.attr('string', { defaultValue: 'pistachio' })

Notdvs.Task = Notdvs.Model.extend
  title: DS.attr('string')
  completed: DS.attr('boolean', { defaultValue: false })
  user: DS.belongsTo('user')
  assignee: DS.belongsTo('user')
  assigneeWas: Ember.Object.create()
  deleted: false

  toggleCompleted: ->
    @set('completed', !@get('completed'))

    $.ajax(
      type: if @get('completed') == true then 'POST' else 'DELETE',
      url: '/api/completions',
      dataType: 'json',
      contentType: 'application/json; charset=utf-8',
      data: JSON.stringify({
        completion: {
          user_id: Notdvs.lookup('controller:currentUser').get('id')
          completable: {
            id: @get('id'),
            type: 'Task'
          }
        },
      })
    ).then((data) =>
      Ember.run => @store.pushPayload(data)
    )

  assigneeDidChange: (->
    if @get('assigneeWas.id') != @get('assignee.id')
      @notifyAssignment()
  ).observes('assignee.id')

  assigneeWillChange: (->
    @assigneeWas = @get('assignee')
  ).observesBefore('assignee.id')

  notifyAssignment: ->
    if @get('assignee.id') == Notdvs.lookup('controller:currentUser').get('id')
      new Notify('You have been assigned an issue', { body: @get('title') }).show()

Notdvs.User = DS.Model.extend
  nickname: DS.attr('string')
  avatarUrl: DS.attr('string')

  githubUrl: (->
    "https://github.com/#{@get('nickname')}"
  ).property('nickname')
