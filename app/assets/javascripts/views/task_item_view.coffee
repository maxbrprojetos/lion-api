Lion.TaskItemView = Ember.View.extend
  templateName: 'task_item'
  tagName: 'li'
  classNameBindings: [':task', 'completed', 'isEditing:editing', 'active']

  didInsertElement: ->
    $(document).foundation()
