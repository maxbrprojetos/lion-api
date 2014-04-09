Lion.TaskView = Ember.View.extend
  templateName: 'task'

  didInsertElement: ->
    $(document).foundation()
