#= require jquery
#= require handlebars
#= require pusher
#= require moment
#= require ember
#= require ember-data
#= require ember-pusher
#= require app
#= require_self
#= require notdvs

window.Notdvs = NotdvsApplication.create(
  LOG_ACTIVE_GENERATION: true
  LOG_MODULE_RESOLVER: true
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS: true
)

Notdvs.deferReadiness()