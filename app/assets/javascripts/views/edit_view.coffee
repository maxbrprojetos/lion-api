Lion.EditableView = Ember.Mixin.create
  focusOnInsert: (->
    @$().val @$().val()
    @$().focus()
  ).on('didInsertElement')

Lion.EditTextField = Ember.TextField.extend(Lion.EditableView)
Lion.EditTextArea = Ember.TextArea.extend(Lion.EditableView)

Ember.Handlebars.helper 'edit-text-field', Lion.EditTextField
Ember.Handlebars.helper 'edit-text-area', Lion.EditTextArea
