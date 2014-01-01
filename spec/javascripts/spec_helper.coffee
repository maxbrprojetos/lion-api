#= require sinon
#= require application
#= require ember-mocha-adapter

window.ENV =
  TESTING: true
  PUSHER_KEY: '6702a1273a2dcd88c29f'

mocha.ui('bdd')
mocha.globals(['Ember', 'DS', 'App', 'MD5'])
mocha.timeout(15000)
chai.Assertion.includeStack = true

Ember.Test.adapter = Ember.Test.MochaAdapter.create()
Notdvs.setupForTesting()
Notdvs.injectTestHelpers()

Konacha.reset = Ember.K

window.server = sinon.fakeServer.create()
window.server.autoRespond = true

beforeEach ->
  # ember-pusher connects during initialization process which happens on document ready
  # so we need to disconnect it in order stop pusher from trying to reconnect to a lost connection
  # over and over when the app is reset
  Notdvs.lookup('controller:pusher').get('connection').disconnect()
  Notdvs.reset()

afterEach ->
  window.server.restore()

Notdvs.setup()