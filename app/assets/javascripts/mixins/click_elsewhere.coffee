Lion.ClickElsewhere = Ember.Mixin.create
  onClickElsewhere: Ember.K
  clickElsewhereExcludedSelector: ''

  clickHandler: (->
    @get('elsewhereHandler').bind(this)
  ).property()

  elsewhereHandler: (event) ->
    isThisElement = $(event.target).closest(@get('element')).length == 1
    isExcludedElement = $.inArray(event.target, $(@get('clickElsewhereExcludedSelector'))) != -1

    unless isThisElement || isExcludedElement
      @onClickElsewhere(event)

  didInsertElement: ->
    @_super()
    $(window).on('click', @get("clickHandler"))

  willDestroy: ->
    $(window).off('click', @get("clickHandler"))
    @_super()
