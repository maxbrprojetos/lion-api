Lion.TaskController = Ember.ObjectController.extend(
  needs: ['currentUser']
  currentUser: Ember.computed.alias("controllers.currentUser.content")
  isEditing: false
  bufferedTitle: Ember.computed.oneWay('title')

  guid: (->
    Ember.guidFor(this)
  ).property()

  processedTitle: (->
    @get('title').linkify().htmlSafe()
  ).property('title')

  toggleEditing: ->
    @set('isEditing', !@get('isEditing'))

  removeTask: ->
    task = @get('model')

    if !task.get('completed')
      return unless confirm('Are you sure?')
      task.deleteRecord()
      task.save()
    else
      task.set('hidden', true)

  actions:
    editTask: ->
      @set('isEditing', true)

    doneEditing: ->
      bufferedTitle = @get('bufferedTitle').trim()

      if Ember.isEmpty(bufferedTitle)
        @removeTask()
      else
        task = @get('model')
        title = task.get('title')

        if title != bufferedTitle
          task.set('title', bufferedTitle)
          task.save()

        @set('bufferedTitle', bufferedTitle)
        @set('isEditing', false)

    cancelEditing: ->
      @set('bufferedTitle', @get('title'))
      @set('isEditing', false)

    removeTask: ->
      @removeTask()

    toggleCompleted: ->
      task = @get('model')
      task.toggleCompleted(@get('currentUser'))

    assignUser: (user) ->
      task = @get('model')

      if task.get('assignee.id') != user.get('id')
        task.set('assignee', user)
        task.save()
)
