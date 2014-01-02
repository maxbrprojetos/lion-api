#= require sinon
#= require application
#= require ember-mocha-adapter

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

window.server = sinon.fakeServer.create()
window.server.autoRespond = true

$.fx.off = true

afterEach ->
  Notdvs.reset()

Notdvs.setup()
Notdvs.advanceReadiness()

server.respondWith('GET', '/api/notices', [
  200,
  { 'Content-Type': 'application/json' },
  '{ "notices": [] }'
])

server.respondWith('POST', '/api/notices', [
  201,
  { 'Content-Type': 'application/json' },
  '{
    "notice": {
      "id": "a5babb5f-e5b2-4ccf-85fc-4893f8d08d1f",
      "title": "test",
      "created_at": "2014-01-02T14:01:02.810Z",
      "client_id": "1388671262720",
      "type": "warning"
    }

  }'
])

server.respondWith('DELETE', /\/api\/notices\/(.*)/, [
  204,
  { 'Content-Type': 'application/json' },
  ''
])