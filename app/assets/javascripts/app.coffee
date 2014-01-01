unless window.NotdvsApplication
  window.NotdvsApplication = Ember.Application.extend
    LOG_TRANSITIONS: true

    lookup: ->
      @__container__.lookup.apply(@__container__, arguments)

    setup: ->
      if ENV['PUSHER_KEY']
        @reopen
          PUSHER_OPTS:
            key: ENV['PUSHER_KEY']

    reset: ->
      @setup()
      @_super()