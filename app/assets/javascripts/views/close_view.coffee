Notdvs.CloseView = Ember.View.extend
  templateName: 'close'
  tagName: 'span'

  click: ->
    parentView = @get('parentView')

    parentView.$().one('webkitAnimationEnd mozAnimationEnd oAnimationEnd animationEnd', =>
      parentView.$().off()
      parentView.get('controller').send('delete')
    )

    @get('parentView').set('isClosing', true)
    false