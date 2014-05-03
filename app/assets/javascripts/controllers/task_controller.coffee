Lion.TaskController = Ember.ObjectController.extend(new Lion.Pushable('comment'),
  needs: ['currentUser']
  newCommentBody: ''

  actions:
    createComment: ->
      body = @get('newCommentBody')?.trim()
      return unless body

      comment = @store.createRecord('comment', {
        body: body, user: @get('controllers.currentUser.content'), task: @get('model')
      })

      @get('newRecords').pushObject(comment)
      comment.save()

      @set('newCommentBody', '')

    commentCreate: (payload) ->
      unless @get('newRecords').anyBy('clientId', payload.comment.client_id)
        @store.pushPayload(payload)
        comment = @store.getById('comment', payload.comment.id)
        comment.get('task.comments').addObject(comment)

    commentDestroy: (payload) ->
      comment = @store.getById('comment', payload.comment.id)

      if comment != null && !comment.get('isDirty')
        comment.get('task.comments').removeObject(comment)
        comment.unloadRecord()
)

