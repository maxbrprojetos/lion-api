Lion.TaskView = Ember.View.extend
  classNames: ['comments']
  tagName: 'section'

  didInsertElement: ->
    element = this.$()
    elementWidth = element.width()
    elementOffset = element.offset().left + ((element.outerWidth() - elementWidth) / 2)

    element.stick_in_parent()
      .on('sticky_kit:stick', (e) =>
        element.css('left', elementOffset)
        element.css('width', elementWidth)
      )
      .on('sticky_kit:unstick', (e) ->
        element.css('left', 'auto')
      )
