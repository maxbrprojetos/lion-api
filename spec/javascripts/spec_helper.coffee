#= require sinon
#= require application

window.ENV =
  TESTING: true
  PUSHER_KEY: '6702a1273a2dcd88c29f'

mocha.ui('bdd')
mocha.globals(['Ember', 'DS', 'App', 'MD5'])
mocha.timeout(5)
chai.Assertion.includeStack = true

window.testHelper =
  lookup: (object, object_name) ->
    name = object_name || 'main'
    Notdvs.__container__.lookup("#{object}:#{name}")

  fakeServer: ->
    sinon.fakeServer.create()

Notdvs.Router.reopen
  location: 'none'

Konacha.reset = Ember.K

window.server = testHelper.fakeServer()
window.server.autoRespond = true

Ember.testing = true

beforeEach (done) ->
  Ember.run ->
    Notdvs.advanceReadiness()

    Notdvs.then -> done()

afterEach ->
  window.server.restore()

Notdvs.setup()