Lion.CommentController = Ember.ObjectController.extend
  removeComment: ->
    if confirm('Are you sure?')
      comment = @get('model')
      comment.deleteRecord()
      comment.save()
