Notdvs.EditTaskView = Ember.TextField.extend
  focusOnInsert: (->
    @$().val @$().val()
    @$().focus()
  ).on('didInsertElement')

Ember.Handlebars.helper 'edit-task', Notdvs.EditTaskView