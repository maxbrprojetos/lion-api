#= require sinon
#= require application

window.ENV =
  TESTING: true
  PUSHER_KEY: '6702a1273a2dcd88c29f'

mocha.ui('bdd')
mocha.globals(['Ember', 'DS', 'App', 'MD5'])
mocha.timeout(5)
chai.Assertion.includeStack = true

Notdvs.Router.reopen
  location: 'none'

Konacha.reset = Ember.K

window.server = sinon.fakeServer.create()
window.server.autoRespond = true

Ember.testing = true

beforeEach (done) ->
  Ember.run ->
    Notdvs.reset()

    Notdvs.then -> done()

afterEach ->
  window.server.restore()

Notdvs.setup()