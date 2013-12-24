#= require jquery
#= require handlebars
#= require pusher
#= require ember
#= require ember-model
#= require ember-pusher
#= require_self
#= require notdvs

# for more details see: http://emberjs.com/guides/application/
window.App = Ember.Application.create(
  PUSHER_OPTS:
    key: 'f24760416513053395d4'
    connection:
      encrypted: true
)

App.ApplicationAdapter = Ember.RESTAdapter.extend()