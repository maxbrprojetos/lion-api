# Lion

## What sorcery is this?

Lion is a dashboard for developers written with Ember and Rails.
It notifies developers of problems, it keeps track of tasks and rewards developers when they get shit done®.

## Dependencies

- Postgresql
- Flowdock
- Pusher
- Github

## Features

All the features presented here have a summary page which updates live.
Every action can be either performed via the interface or using the RESTful API.

### Tasks

![tasks](http://cl.ly/image/3n341S0m3b3m/tasks.png)

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

![leaderboard](http://cl.ly/image/0e3Q3001280M/Image%202014-04-13%20at%208.11.59%20pm.png)

There are currently two leaderboards: weekly and all time. The top person in the ladder will always have their bar full, and the other bars are calculated based on the top one.

Points are given according to the following rules.

#### Rules

Completing tasks:

- 1 point

Merging PRs:

- 100 points if the number of deletions is double the number of additions and it's greater than 1000
- 50 points if the number of additions is greater than 500
- 30 points if the number of deletions is double the number of additions and it's greater than 100
- 15 points if the number of additions is greater than 100
- 5 points if the number of additions is less than 10
- 10 points in all the other cases

Reviewing PRs:

- 5 points for commenting with `:+1:`, `:thumbsup:`, `:shipit:`

#### Caveats

In order to get points for merging PRs you need to setup a webhook in your repos that points to:

```
https://your.lion.installation.com/api/pull_requests
```

### Hall of Fame

Weekly winners will be placed here.
In order to declare a weekly winner run the `hall_of_fame:declare_weekly_winner` rake task every monday morning.

![hall-of-fame](http://cl.ly/image/0w3F2g2L1n3a/Image%202014-04-13%20at%208.14.26%20pm.png)

### Stats

Displayed stats:

- Number of merged PRs
- Number of reviews
- Total number of additions across merged PRs
- Total number of deletions across merged PRs
- Number of completed tasks

![stats](http://cl.ly/image/3z1A0C2D0x0p/Image%202014-04-13%20at%208.16.57%20pm.png)

### Badges

Coming soon :)
