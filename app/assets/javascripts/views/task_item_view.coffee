Lion.TaskItemView = Ember.View.extend
  templateName: 'task_item'
  tagName: 'li'
  classNameBindings: [':task', 'controller.completed', 'isEditing:editing', 'active']

  didInsertElement: ->
    $(document).foundation()
