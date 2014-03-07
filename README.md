## What sorcery is this?

NOtices To DeveloperS is a dashboard for developers written with Ember and Rails.
It notifies developers of problems, it keeps track of tasks and rewards developers when they get shit done®.

## Dependencies

- Postgresql
- Flowdock
- Pusher
- Github

## Features

All the features presented here have a summary page which updates live.
Every action can be either performed via the interface of using the RESTful API.

### Notices

![notices](http://cl.ly/image/2U1C0i1p0T2Z)

Whenever something goes wrong in your system, you can POST to the /notices path and create a new notice, like this:

```
# POST /notices

+ Request application/json

        {
          "notice": {
            "title": "test",
            "client_id": "1234",
            "app": "testapp",
            "type": "error"
          }
        }

+ Response 201 application/json; charset=utf-8

        {
          "notice": {
            "client_id": "1234",
            "id": "2009bb77-edc8-4b81-9bd9-3ed90e7b7e46",
            "title": "test",
            "created_at": "2014-03-07T10:56:07.125Z",
            "type": "error",
            "app": "testapp"
          }
        }
```

Mandatory fields: `app`, `title`.
If you don't specify any type `notice` will be used.

### Tasks

![tasks](http://cl.ly/image/2n2w0c3J3x3Y)

You can create your tasks with the API like this:

```
# POST /tasks

+ Request application/json

        {
          "task": {
            "title": "test",
            "client_id": "1234"
          }
        }

+ Response 201 application/json; charset=utf-8

        {
          "users": [
            {
              "id": "7be0dd9f-402e-445b-aa61-c3d6ca9c6fcb",
              "avatar_url": "omg",
              "nickname": "current_user",
              "points": 0
            }
          ],
          "task": {
            "client_id": "1234",
            "id": "c7022279-768b-425f-9ea1-ff83921b4784",
            "title": "test",
            "created_at": "2014-03-07T10:56:06.997Z",
            "completed": false,
            "assignee_id": null,
            "user_id": "7be0dd9f-402e-445b-aa61-c3d6ca9c6fcb"
          }
        }
```

If you want to assign someone you can update the task like this:

```
# PATCH /tasks/{id}

+ Request application/json

        {
          "task": {
            "title": "omg",
            "assignee_id": "b4135486-69ba-4fee-9530-0eaeebe52209"
          }
        }

+ Response 200 application/json; charset=utf-8

        {
          "users": [
            {
              "id": "db2d88d3-f87f-45f8-9d04-055dd6fe49e2",
              "avatar_url": "http://lol.com/omg14.png",
              "nickname": "test14",
              "points": 0
            }
          ],
          "task": {
            "client_id": null,
            "id": "cb7d8a67-88e9-4365-8411-b637fe306469",
            "title": "omg",
            "created_at": "2014-03-07T10:56:07.018Z",
            "completed": false,
            "assignee_id": "b4135486-69ba-4fee-9530-0eaeebe52209",
            "user_id": "db2d88d3-f87f-45f8-9d04-055dd6fe49e2"
          }
```

### Leaderboard

![leaderboard](http://cl.ly/image/211U1A033h3J)

Points are calculated this way:

- 5 points for completing tasks
- 15 points for getting your PRs merged

In order to get your PRs merged you need to setup a webhook in your repos that points to:

```
https://your.notdvs.installation.com/api/pull_request_mergers
```

The top person in the ladder will always have their bar full, and the others are calculated based on the top one.
