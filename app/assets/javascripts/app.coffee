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
      # stop pusher from trying to reconnect to a connection that might be killed
      # by the initialization process that happens at reset time
      @lookup('controller:pusher').get('connection').disconnect()
      @setup()
      @_super.apply(this, arguments)

    ready: ->
      Notify.prototype.requestPermission() if Notify.prototype.isSupported() && Notify.prototype.needsPermission()
