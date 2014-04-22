Lion.TaskView = Ember.View.extend
  classNames: ['comments']
  tagName: 'section'

  didInsertElement: ->
    element = this.$()
    elementOffset = element.offset().left + ((element.outerWidth() - element.width()) / 2)

    element.stick_in_parent()
      .on('sticky_kit:stick', (e) =>
        element.css('left', elementOffset)
        element.css('width', element.width())
      )
      .on('sticky_kit:unstick', (e) ->
        element.css('left', 'auto')
      )
