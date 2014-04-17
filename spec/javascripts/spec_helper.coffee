#= require sinon
#= require application
#= require ember-mocha-adapter
#= require server-mocks

window.ENV =
  TESTING: true
  PUSHER_KEY: '6702a1273a2dcd88c29f'

Ember.Test.adapter = Ember.Test.MochaAdapter.create()
Lion.setupForTesting()
Lion.injectTestHelpers()

mocha.globals(['Ember', 'DS', 'Lion', 'MD5'])
mocha.timeout(15000)
chai.Assertion.includeStack = true

Konacha.reset = Ember.K

$.fx.off = true

beforeEach ->
  Lion.reset()

Lion.setup()
