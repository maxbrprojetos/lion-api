#= require jquery
#= require handlebars
#= require pusher
#= require ember
#= require ember-data
#= require ember-pusher
#= require app
#= require_self
#= require notdvs

window.ENV = { PUSHER_KEY: '50d9af5dd017f737f67e' }

window.Notdvs = NotdvsApplication.create(
  LOG_ACTIVE_GENERATION: true
  LOG_MODULE_RESOLVER: true
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS: true
  PUSHER_OPTS:
    key: ENV['PUSHER_KEY']
    connection:
      encrypted: true
)

Notdvs.deferReadiness()

$.extend Notdvs,
  run: ->
    Notdvs.advanceReadiness()
