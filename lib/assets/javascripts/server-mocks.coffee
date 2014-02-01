window.server = sinon.fakeServer.create()

server.autoRespond = true

# notices

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
        "client_id": "1234",
        "id": "d9423b0f-de3a-4622-9c2c-6884ca117f42",
        "title": "test",
        "created_at": "2014-01-31T12:18:58.438Z",
        "type": "error",
        "app": "testapp"
      }
    }
  }'
])

server.respondWith('DELETE', /\/api\/notices\/(.*)/, [
  204,
  { 'Content-Type': 'application/json' },
  ''
])

# tasks

server.respondWith('GET', '/api/tasks', [
  200,
  { 'Content-Type': 'application/json' },
  '{ "tasks": [] }'
])

server.respondWith('POST', '/api/tasks', [
  201,
  { 'Content-Type': 'application/json' },
  '{
      "users": [
        {
          "id": "52246568-bc3b-4152-9a8b-59cf058ae382",
          "avatar_url": "omg",
          "nickname": "lol",
          "points": 0
        }
      ],
      "task": {
        "client_id": "1234",
        "id": "1072b949-f895-4de4-a422-41c29b6ee8de",
        "title": "test",
        "created_at": "2014-01-31T12:18:58.203Z",
        "completed": false,
        "assignee_id": null,
        "user_id": "52246568-bc3b-4152-9a8b-59cf058ae382"
      }
    }
  }'
])

server.respondWith('DELETE', /\/api\/tasks\/(.*)/, [
  204,
  { 'Content-Type': 'application/json' },
  ''
])

server.respondWith('PUT', /\api\/tasks\/(.*)/, [
  200,
  { 'Content-Type': 'application/json' },
  '
    {
      "users": [

      ],
      "task": {
        "client_id": null,
        "id": "22ea3555-f98b-4e8f-85cd-176bee85bc5e",
        "title": "omg",
        "created_at": "2014-01-31T12:18:58.227Z",
        "completed": false,
        "assignee_id": "8b086914-86f5-4054-aa79-3b2cb2f21890",
        "user_id": null
      }
    }
  '
])