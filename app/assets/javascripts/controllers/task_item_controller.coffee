Lion.TaskItemController = Ember.ObjectController.extend(Lion.Editable,
  editableField: 'title'
  needs: ['currentUser']
  currentUser: Ember.computed.alias('controllers.currentUser.content')

  guid: (->
    Ember.guidFor(this)
  ).property()

  remove: ->
    task = @get('model')

    if !task.get('completed')
      return unless confirm('Are you sure?')
      task.deleteRecord()
      task.save()
    else
      task.set('hidden', true)

  actions:
    remove: ->
      @remove()

    toggleCompleted: ->
      task = @get('model')
      task.toggleCompleted(@get('currentUser'))

    assignUser: (user) ->
      task = @get('model')

      if task.get('assignee.id') != user.get('id')
        task.set('assignee', user)
        task.save()
)
