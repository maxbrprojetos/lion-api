Notdvs.TaskController = Ember.ObjectController.extend(
  needs: ['currentUser']
  isEditing: false
  bufferedTitle: Ember.computed.oneWay('title')

  guid: (->
    Ember.guidFor(this)
  ).property()

  processedTitle: (->
    @get('title').linkify()
  ).property('title')

  toggleEditing: ->
    @set('isEditing', !@get('isEditing'))

  removeTask: ->
    task = @get('model')
    task.deleteRecord()
    task.save()

  actions:
    editTask: ->
      Ember.run.debounce(this, 'toggleEditing', 0)

    doneEditing: ->
      bufferedTitle = @get('bufferedTitle').trim()

      if Ember.isEmpty(bufferedTitle)
        # The `doneEditing` action gets sent twice when the user hits
        # enter (once via 'insert-newline' and once via 'focus-out').
        #
        # We debounce our call to 'removeTask' so that it only gets
        # sent once.
        Ember.run.debounce(this, 'removeTask', 0)
      else
        task = @get('model')
        title = task.get('title')

        if title != bufferedTitle
          task.set('title', bufferedTitle)
          task.save()

      @set('bufferedTitle', bufferedTitle)
      Ember.run.debounce(this, 'toggleEditing', 0)

    cancelEditing: ->
      @set('bufferedTitle', @get('title'))
      @set('isEditing', false)

    removeTask: ->
      @removeTask()

    toggleCompleted: ->
      task = @get('model')
      task.toggleCompleted()

    assignUser: (user) ->
      task = @get('model')

      if task.get('assignee.id') != user.get('id')
        task.set('assignee', user)
        task.save()
)
