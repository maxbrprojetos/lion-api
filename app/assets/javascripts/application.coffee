#= require jquery
#= require handlebars
#= require ember
#= require ember-model
#= require_self
#= require notdvs

# for more details see: http://emberjs.com/guides/application/
window.App = Ember.Application.create()

App.ApplicationAdapter = Ember.RESTAdapter.extend()