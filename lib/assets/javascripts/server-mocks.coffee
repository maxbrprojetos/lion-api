window.server = sinon.fakeServer.create()

server.autoRespond = true

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