Lion.CommentsController = Ember.ArrayController.extend(new Lion.Pusherable('comment'),
  actions:
    createComment: (task) ->
      body = @get('body')?.trim()
      return unless body

      comment = @store.createRecord('comment',
        body: body,
        task: task
      )

      @get('newRecords').pushObject(comment)
      comment.save()

      @set 'body', ''
)

