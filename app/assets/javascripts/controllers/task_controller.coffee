Lion.TaskController = Ember.ObjectController.extend
  needs: ['currentUser']

  actions:
    createComment: ->
      body = @get('body')?.trim()
      return unless body

      comment = @store.createRecord('comment', {
        body: body, user: @get('controllers.currentUser.content'), task: @get('model')
      })
      comment.save()

      @set('body', '')
