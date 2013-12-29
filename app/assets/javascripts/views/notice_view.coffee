Notdvs.NoticeView = Ember.View.extend
  templateName: 'notice'
  classNameBindings: ['isClosing:closing']
  isClosing: false

  isClosingChanged: (->
    return unless @get('isClosing')

    @$().one('webkitAnimationEnd mozAnimationEnd oAnimationEnd animationEnd', =>
      @$().off()
      @get('controller').send('delete')
    )
  ).observes('isClosing')
