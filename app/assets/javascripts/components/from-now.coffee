Notdvs.FromNowComponent = Ember.Component.extend
  tagName: 'time'
  template: Ember.Handlebars.compile('{{view.output}}')

  output: (->
    moment(this.get('value')).fromNow()
  ).property('value')

  didInsertElement: ->
    @tick()

  tick: ->
    nextTick = Ember.run.later(this, ->
      @notifyPropertyChange('value')
      @tick()
    , 1000)

    @set('nextTick', nextTick)

  willDestroyElement: ->
    nextTick = @get('nextTick')
    Ember.run.cancel(nextTick)