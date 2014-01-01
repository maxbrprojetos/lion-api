unless window.NotdvsApplication
  window.NotdvsApplication = Ember.Application.extend
    LOG_TRANSITIONS: true

    lookup: ->
      @__container__.lookup.apply @__container__, arguments

    setup: ->
      if ENV['PUSHER_KEY']
        @reopen
          PUSHER_OPTS:
            key: ENV['PUSHER_KEY']

    disconnectPusher: ->
      @lookup('controller:pusher').get('connection').disconnect()

    reset: ->
      @disconnectPusher()
      @_super()