Lion.TaskController = Ember.ObjectController.extend
  needs: ['currentUser']
  newCommentBody: ''

  actions:
    createComment: ->
      body = @get('newCommentBody')?.trim()
      return unless body

      comment = @store.createRecord('comment', {
        body: body, user: @get('controllers.currentUser.content'), task: @get('model')
      })
      comment.save()

      @set('newCommentBody', '')
