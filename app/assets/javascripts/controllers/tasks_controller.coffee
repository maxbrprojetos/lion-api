Lion.TasksController = Ember.ArrayController.extend(new Lion.Pusherable('task'),
  needs: ['currentUser']
  queryParams: ['filter']
  filter: null
  null: null

  persistedTasks: Ember.computed.filterBy('filteredTasks', 'hidden', false)
  sortedTasks: Ember.computed.sort('persistedTasks', (a, b) ->
    if a.get('createdAt') < b.get('createdAt')
      return 1
    else if a.get('createdAt') > b.get('createdAt')
      return -1
    return 0
  )

  filteredTasks: (->
    tasks = @get('model')

    if @get('filter') == 'mine'
      currentUserId = @get('controllers.currentUser').get('content.id')

      tasks.filter((task) ->
        if !Ember.isEmpty(task.get('assignee'))
          task.get('assignee.id') == currentUserId
        else
          task.get('user.id') == currentUserId
      )
    else
      tasks
  ).property('filter', 'model')

  actions:
    createTask: ->
      title = @get('newTitle')?.trim()
      return unless title

      task = @store.createRecord('task',
        title: title
      )

      @get('newRecords').pushObject(task)
      task.save()

      @set 'newTitle', ''

  remaining: (->
    @get('filteredTasks').filterProperty('completed', false).get('length')
  ).property('filteredTasks.@each.completed')

  remainingFormatted: (->
    remaining = @get('remaining')
    plural = if remaining == 1 then 'item' else 'items'
    '<strong>%@</strong> %@ left'.fmt(remaining, plural)
  ).property('remaining')
)
