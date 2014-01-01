unless window.NotdvsApplication
  window.NotdvsApplication = Ember.Application.extend
    LOG_TRANSITIONS: true

    setup: ->
      if ENV['PUSHER_KEY']
        @reopen
          PUSHER_OPTS:
            key: ENV['PUSHER_KEY']