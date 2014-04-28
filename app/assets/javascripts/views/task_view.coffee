Lion.TaskView = Ember.View.extend(Lion.ClickElsewhere,
  classNames: ['task']
  tagName: 'section'
  clickElsewhereExcludedSelector: '.fa-comments-o, .task_item footer'

  onClickElsewhere: ->
    @get('controller').send('close')
)
