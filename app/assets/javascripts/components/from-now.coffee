Notdvs.FromNowComponent = Ember.Component.extend
  tagName: 'time'
  template: Ember.Handlebars.compile('{{view.output}}')

  output: (->
    moment(@get('value')).from(@get('now'))
  ).property('now')

  tick: ->
    @set('now', new Date())
    @scheduleTick()

  didInsertElement: ->
    @tick()

  scheduleTick: ->
    nextTick = Ember.run.later(this, ->
      @tick()
    , 1000)

    @set('nextTick', nextTick)

  willDestroyElement: ->
    nextTick = @get('nextTick')
    Ember.run.cancel(nextTick)