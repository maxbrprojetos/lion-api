Lion.Task = DS.Model.extend(DS.Pushable, DS.Creatable,
  title: DS.attr('string')
  completed: DS.attr('boolean', { defaultValue: false })
  user: DS.belongsTo('user')
  assignee: DS.belongsTo('user')
  assigneeWas: Ember.Object.create()
  hidden: false
  comments: DS.hasMany('comment')
  hideAfterCompleteDelay: 5000
  currentHideTimer: false

  toggleCompleted: (user) ->
    @set('completed', !@get('completed'))

    if @currentHideTimer
      Ember.run.cancel(@currentHideTimer)
      @currentHideTimer = false

    if @get('completed')
      @store.createRecord('taskCompletion', {
        task: this,
        user: user
      }).save()

      @currentHideTimer = Ember.run.later(@, ( =>
        @set('hidden', true)
      ), @hideAfterCompleteDelay)
    else
      $.ajax(
        type: 'DELETE',
        url: '/api/task_completions',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({ task_id: @get('id') })
      ).then((data) =>
        Ember.run => @store.pushPayload(data.task_completion)
      )

  assigneeDidChange: (->
    if @get('assigneeWas.id') != @get('assignee.id')
      @notifyAssignment()
  ).observes('assignee.id')

  assigneeWillChange: (->
    @assigneeWas = @get('assignee')
  ).observesBefore('assignee.id')

  notifyAssignment: ->
    if @get('assignee.id') == Lion.lookup('controller:currentUser').get('id')
      new Notify('You have been assigned an issue', { body: @get('title') }).show()
)
