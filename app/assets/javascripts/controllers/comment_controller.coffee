Lion.CommentController = Ember.ObjectController.extend
  isEditing: false
  bufferedBody: Ember.computed.oneWay('body')

  removeComment: ->
    return unless confirm('Are you sure?')
    comment = @get('model')
    comment.deleteRecord()
    comment.save()

  actions:
    removeComment: ->
      @removeComment()

    toggleEditing: ->
      @set('isEditing', !@get('isEditing'))

    editComment: ->
      @set('isEditing', true)

    doneEditing: ->
      bufferedBody = @get('bufferedBody').trim()

      if Ember.isEmpty(bufferedBody)
        @removeComment()
      else
        comment = @get('model')
        body = comment.get('body')

        if body != bufferedBody
          comment.set('body', bufferedBody)
          comment.save()

        @set('bufferedBody', bufferedBody)
        @set('isEditing', false)

    cancelEditing: ->
      @set('bufferedBody', @get('body'))
      @set('isEditing', false)
