Lion.TaskController = Ember.ObjectController.extend
  actions:
    createComment: ->
      body = @get('body')?.trim()
      return unless body

      comment = @store.createRecord('comment', { body: body, task: @get('model') })
      comment.save()

      @set('body', '')
