Notdvs.FromNowComponent = Ember.Component.extend
  tagName: 'time'
  template: Ember.Handlebars.compile('{{view.output}}')

  output: (->
    moment(@get('value')).from(@get('now'))
  ).property('now')

  now: (->
    currentTime = new Date()
    createdAt = @get('created_at')

    if currentTime < createdAt
      createdAt
    else
      currentTime
  ).property()

  didInsertElement: ->
    @tick()

  tick: ->
    @notifyPropertyChange('now')

    nextTick = Ember.run.later(this, ->
      @tick()
    , 1000)

    @set('nextTick', nextTick)

  willDestroyElement: ->
    nextTick = @get('nextTick')
    Ember.run.cancel(nextTick)