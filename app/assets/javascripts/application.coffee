#= require extensions
#= require jquery
#= require vendor/modernizr
#= require foundation/foundation
#= require foundation.dropdown
#= require pace
#= require notify
#= require handlebars
#= require pusher
#= require moment
#= require ember
#= require ember-data
#= require ember-pusher
#= require ember-simple-auth
#= require app
#= require_self
#= require lion

window.Lion = LionApplication.create(
  LOG_ACTIVE_GENERATION: true
  LOG_MODULE_RESOLVER: true
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS: true
)

Lion.deferReadiness()

Ember.SimpleAuth.Session.reopen
  login: ->
    Lion.lookup('controller:currentUser').sync()

  logout: ->
    Lion.lookup('controller:currentUser').logout()

Ember.Application.initializer
  name: 'authentication'

  initialize: (container, application) ->
    Ember.SimpleAuth.setup(container, application, {
      routeAfterLogin: 'tasks'
      routeAfterLogout: 'login'
    })
