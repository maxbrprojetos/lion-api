Lion.TasksController = Ember.ArrayController.extend(new Ember.Pushable('task'),
  needs: ['currentUser']
  queryParams: ['filter']
  filter: null

  userSorting: ['nickname']
  sortedUsers: Ember.computed.sort('users', 'userSorting')

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
  ).property('filter', 'model.[]')

  visibleTasks: (->
    @get('filteredTasks').filter((task) -> !task.get('hidden'))
  ).property('filteredTasks.@each.hidden')

  sortedTasks: (->
    @get('visibleTasks').toArray().sort((a, b) ->
      aPriority = a.get('title').match(/^\[\d\]/)?[0]
      bPriority = b.get('title').match(/^\[\d\]/)?[0]

      if aPriority && bPriority
        if aPriority < bPriority
          return -1
        else if aPriority > bPriority
          return 1

      Ember.compare(b.get('createdAt'), a.get('createdAt'))
    )
  ).property('visibleTasks.@each.{createdAt,title}')

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
