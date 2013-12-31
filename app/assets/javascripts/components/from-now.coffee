Notdvs.FromNowComponent = Ember.Component.extend
  tagName: 'time'
  template: Ember.Handlebars.compile('{{view.output}}')

  output: (->
    moment(@get('value')).from(@get('now'))
  ).property('now')

  now: (->
    currentTime = @get('currentTime')
    createdAt = @get('value')

    if currentTime < createdAt
      createdAt
    else
      currentTime
  ).property('currentTime')

  didInsertElement: ->
    @tick()

  tick: ->
    @set('currentTime', new Date())

    nextTick = Ember.run.later(this, ->
      @tick()
    , 1000)

    @set('nextTick', nextTick)

  willDestroyElement: ->
    nextTick = @get('nextTick')
    Ember.run.cancel(nextTick)