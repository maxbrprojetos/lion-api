Notdvs.TaskController = Ember.ObjectController.extend(
  isEditing: false
  bufferedTitle: Ember.computed.oneWay('title')

  actions:
    editTask: ->
      @set('isEditing', true)

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
        task.set('title', bufferedTitle)
        task.save()

      @set('bufferedTitle', bufferedTitle)
      @set('isEditing', false)

    cancelEditing: ->
      @set('bufferedTitle', @get('title'))
      @set('isEditing', false)

    removeTask: ->
      task = @get('model')
      task.deleteRecord()
      task.save()

    toggleCompleted: ->
      @set('completed', !@get('completed'))

    assignUser: (user) ->
      task = @get('model')
      task.set('assignee', user)
      task.save()
)