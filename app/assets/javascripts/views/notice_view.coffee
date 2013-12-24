App.NoticeView = Ember.View.extend
  templateName: 'notice'

  willDestroyElement: ->
    clone = @$().clone()

    clone.one('webkitAnimationEnd mozAnimationEnd oAnimationEnd animationEnd', ->
      clone.off().remove()
    )

    @$().parents(':first').prepend clone
    clone.addClass 'animated fadeOutRight'
