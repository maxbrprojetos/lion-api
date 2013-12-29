Notdvs.NoticeView = Ember.View.extend
  templateName: 'notice'
  classNameBindings: ['isClosing:closing']
  isClosing: false

  didInsertElement: ->
    @$('.close').on('click', (event) =>
      event.preventDefault()
      @set('isClosing', true)
    )

  isClosingChanged: (->
    @$().on('webkitAnimationEnd mozAnimationEnd oAnimationEnd animationEnd animationend', =>
      @get('controller').send('delete')
    )
  ).observes('isClosing')
