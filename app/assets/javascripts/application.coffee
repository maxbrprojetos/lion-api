#= require jquery
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
#= require notdvs

window.Notdvs = NotdvsApplication.create(
  LOG_ACTIVE_GENERATION: true
  LOG_MODULE_RESOLVER: true
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS: true
)

Notdvs.deferReadiness()

Ember.SimpleAuth.Session.reopen
  login: (data) ->
    currentUser = Notdvs.lookup('store:main').pushPayload('user', data)
    Notdvs.LocalStorage.setItem('currentUser', data.user)

  logout: ->
    Notdvs.LocalStorage.removeItem('currentUser')

Ember.Application.initializer
  name: 'authentication'

  initialize: (container, application) ->
    Ember.SimpleAuth.setup(container, application, {
      routeAfterLogin: 'notices'
      routeAfterLogout: 'login'
    })