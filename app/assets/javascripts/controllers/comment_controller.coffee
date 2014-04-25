Lion.CommentController = Ember.ObjectController.extend(Lion.Editable,
  editableField: 'body'

  remove: ->
    return unless confirm('Are you sure?')
    comment = @get('model')
    comment.deleteRecord()
    comment.save()

  actions:
    remove: ->
      @remove()
)
