Notdvs.TaskController = Ember.ObjectController.extend(
  isEditing: false
  bufferedTitle: Ember.computed.oneWay('title')

  isCompleted: ((key, value)->
    if arguments.length == 1
      @get('completed')
    else
      @set('completed', value)
      @get('model').save()
  ).property()

  actions:
    editTask: ->
      @set('isEditing', true)

    doneEditing: ->
      bufferedTitle = @get('bufferedTitle').trim()

      if Ember.isEmpty(bufferedTitle)
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
)