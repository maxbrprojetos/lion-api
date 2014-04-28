Lion.ClickElsewhere = Ember.Mixin.create
  onClickElsewhere: Ember.K
  clickElsewhereExcludedSelector: ''

  clickHandler: (->
    @get('elsewhereHandler').bind(this)
  ).property()

  elsewhereHandler: (event) ->
    isThisElement = $(event.target).closest(@get('element')).length == 1
    isExcludedElement = event.target.matches(@get('clickElsewhereExcludedSelector'))

    if !isExcludedElement && !isThisElement
      @onClickElsewhere(event)

  didInsertElement: ->
    @_super()
    $(window).on('click', @get("clickHandler"))

  willDestroy: ->
    $(window).off('click', @get("clickHandler"))
    @_super()
