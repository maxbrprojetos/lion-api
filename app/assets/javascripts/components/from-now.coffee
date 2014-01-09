Notdvs.FromNowComponent = Ember.Component.extend
  tagName: 'time'
  template: Ember.Handlebars.compile('{{view.timeFromNowInWords}}')

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

    # don't use Ember.run.later because tests will wait for timers to expire and this will never happen
    nextTick = setTimeout(=>
      Ember.run(=>
        @tick()
      )
    , 1000)

    @set('nextTick', nextTick)

  willDestroyElement: ->
    nextTick = @get('nextTick')
    clearTimeout(nextTick)