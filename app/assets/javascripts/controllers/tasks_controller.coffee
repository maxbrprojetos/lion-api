Notdvs.TasksController = Ember.ArrayController.extend(new Notdvs.Pusherable('task'),
  persistedTasks: Ember.computed.filterBy('filteredTasks', 'deleted', false)
  sortedTasks: Ember.computed.sort('persistedTasks', (a, b) ->
    if a.get('createdAt') < b.get('createdAt')
      return 1
    else if a.get('createdAt') > b.get('createdAt')
      return -1
    return 0
  )

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
