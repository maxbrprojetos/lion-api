Lion.FromNowComponent = Ember.Component.extend
  tagName: 'time'
  layout: Ember.Handlebars.compile('{{view.timeFromNowInWords}}')

  timeFromNowInWords: (->
    moment(@get('time')).fromNow()
  ).property('time')

  time: (->
    time = @get('value')
    now = new Date()

    if now < time
      now
    else
      time
  ).property('value')

  didInsertElement: ->
    @tick()

  tick: ->
    @notifyPropertyChange('value')

    nextTick = Ember.run.later(=>
      @tick()
    , 1000)

    @set('nextTick', nextTick)

  willDestroyElement: ->
    nextTick = @get('nextTick')
    Ember.run.cancel(nextTick)
