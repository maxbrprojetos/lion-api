Lion.TaskItemView = Ember.View.extend
  templateName: 'task_item'

  didInsertElement: ->
    $(document).foundation()
