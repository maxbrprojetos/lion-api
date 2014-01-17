Notdvs.TasksController = Ember.ArrayController.extend(EmberPusher.Bindings,
  PUSHER_SUBSCRIPTIONS:
    notdvs: ['task.create', 'task.update', 'task.destroy']

  newTasks: Ember.A([])

  actions:
    createTask: ->
      title = undefined
      task = undefined

      title = @get('newTitle').trim()
      return unless title

      task = @store.createRecord('task',
        title: title
        client_id: new Date().getTime().toString()
      )

      @get('newTasks').pushObject(task)
      task.save()

      @set 'newTitle', ''

    # pusher
    taskCreate: (payload) ->
      @store.pushRecord('task', payload.task) unless @get('newTasks').anyBy('client_id', payload.task.client_id)

    taskUpdate: (payload) ->
      @store.pushRecord('task', payload.task)

    taskDestroy: (payload) ->
      task = @store.getById('task', payload.task.id)
      task.unloadRecord() if task != null && !task.get('isDirty')

  remaining: (->
    @get('content.length')
  ).property('@each.length')

  allAreDone: (->
    if @get('remaining') == 0 then true else false
  ).property('remaining')

  remainingFormatted: (->
    remaining = @get('remaining')
    plural = if remaining == 1 then 'item' else 'items'
    '<strong>%@</strong> %@ left'.fmt(remaining, plural)
  ).property('remaining')
)