Lion.TaskItemView = Ember.View.extend
  templateName: 'task_item'
  tagName: 'li'
  classNameBindings: [':task_item', 'controller.completed', 'isEditing:editing', 'active', 'controller.id']

  didInsertElement: ->
    $(document).foundation()
