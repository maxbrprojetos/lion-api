#= require sinon
#= require application
#= require ember-mocha-adapter
#= require server-mocks

window.ENV =
  TESTING: true
  PUSHER_KEY: '6702a1273a2dcd88c29f'

Ember.Test.adapter = Ember.Test.MochaAdapter.create()
Notdvs.setupForTesting()
Notdvs.injectTestHelpers()

mocha.globals(['Ember', 'DS', 'Notdvs', 'MD5'])
mocha.timeout(2000)
chai.Assertion.includeStack = true

Konacha.reset = Ember.K

$.fx.off = true

afterEach ->
  Notdvs.reset()

Notdvs.setup()
Notdvs.advanceReadiness()