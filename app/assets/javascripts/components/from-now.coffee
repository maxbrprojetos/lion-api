Notdvs.FromNowComponent = Ember.Component.extend
  tagName: 'time'
  template: Ember.Handlebars.compile('{{view.timeFromNowInWords}}')

  timeFromNowInWords: (->
    moment(@get('time')).from(@get('now'))
  ).property('now', 'time')

  time: (->
    time = @get('value')
    now = @get('now')

    if now < time
      now
    else
      time
  ).property('now', 'value')

  didInsertElement: ->
    @tick()

  tick: ->
    @set('now', new Date())

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