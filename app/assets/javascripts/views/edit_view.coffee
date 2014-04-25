Lion.EditView = Ember.TextField.extend
  focusOnInsert: (->
    @$().val @$().val()
    @$().focus()
  ).on('didInsertElement')

Ember.Handlebars.helper 'edit-view', Lion.EditView
