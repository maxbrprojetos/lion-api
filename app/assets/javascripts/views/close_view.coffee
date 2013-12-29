Notdvs.CloseView = Ember.View.extend
  templateName: 'close'
  tagName: 'span'

  click: ->
    @get('parentView').set('isClosing', true)
    false