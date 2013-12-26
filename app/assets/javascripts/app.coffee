unless window.NotdvsApplication
  window.NotdvsApplication = Ember.Application.extend
    LOG_TRANSITIONS: true

    modelClasses: (->
      [Notdvs.Notice]
    ).property()

    setup: ->
      @get('modelClasses').forEach (klass) ->
        klass.adapter = Notdvs.Adapter.create()
        klass.url = "api/#{klass.pluralName()}"