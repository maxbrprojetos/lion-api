Notdvs.TaskController = Ember.ObjectController.extend(
  isEditing: false
  bufferedTitle: Ember.computed.oneWay('title')

  guid: (->
    Ember.guidFor(this)
  ).property()

  toggleEditing: ->
    @set('isEditing', !@get('isEditing'))

  actions:
    editTask: ->
      Ember.run.debounce(this, @toggleEditing, 100)

    doneEditing: ->
      bufferedTitle = @get('bufferedTitle').trim()

      if Ember.isEmpty(bufferedTitle)
        # The `doneEditing` action gets sent twice when the user hits
        # enter (once via 'insert-newline' and once via 'focus-out').
        #
        # We debounce our call to 'removeTask' so that it only gets
        # sent once.
        Ember.run.debounce(this, @send, 'removeTask', 0)
      else
        task = @get('model')
        title = task.get('title')

        if title != bufferedTitle
          task.set('title', bufferedTitle)
          task.save()

      @set('bufferedTitle', bufferedTitle)
      Ember.run.debounce(this, @toggleEditing, 100)

    cancelEditing: ->
      @set('bufferedTitle', @get('title'))
      @set('isEditing', false)

    removeTask: ->
      task = @get('model')
      task.deleteRecord()
      task.save()

    toggleCompleted: ->
      task = @get('model')
      task.set('completed', !@get('completed'))
      task.save()

    assignUser: (user) ->
      task = @get('model')

      if task.get('assignee.id') != user.get('id')
        task.set('assignee', user)
        task.save().then((task) ->
          new Notify('You have been assigned an issue', { body: task.get('title') }).show()
        )
)