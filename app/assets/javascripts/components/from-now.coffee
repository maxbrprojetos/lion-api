Notdvs.FromNowComponent = Ember.Component.extend
  tagName: 'time'
  template: Ember.Handlebars.compile('{{view.output}}')

  output: (->
    moment(@get('value')).from(@get('now'))
  ).property('now')

  didInsertElement: ->
    @tick()

  tick: ->
    @set('now', new Date())

    nextTick = Ember.run.later(this, ->
      @tick()
    , 1000)

    @set('nextTick', nextTick)

  willDestroyElement: ->
    nextTick = @get('nextTick')
    Ember.run.cancel(nextTick)