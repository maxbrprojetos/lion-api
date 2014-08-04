# Lion API

## What sorcery is this?

Lion is a dashboard for developers written with Ember and Rails.
It rewards developers when they get shit done®.

This is the API. [Here](https://github.com/alphasights/lion) you can find the web client.

## Dependencies

- Postgresql
- Flowdock
- Pusher
- Github

## Features

All the features presented here have a summary page which updates live.
Every action can be either performed via the interface or using the RESTful API.

### Tasks

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
              "id": "0f6ac7e0-f244-4f92-b93a-6924b46161ee",
              "avatar_url": "omg",
              "nickname": "current_user"
            }
          ],
          "comments": [

          ],
          "task": {
            "client_id": "1234",
            "id": "cfb22b79-6907-4724-9c8b-451adf2aec6c",
            "title": "test",
            "created_at": "2014-04-28T08:56:29.859Z",
            "completed": false,
            "assignee_id": null,
            "user_id": "0f6ac7e0-f244-4f92-b93a-6924b46161ee",
            "comment_ids": [

            ]
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
            "assignee_id": "660403f2-f7ab-478f-9f7b-918ef57c9062"
          }
        }

+ Response 200 application/json; charset=utf-8

        {
          "users": [
            {
              "id": "e638ac74-871f-4d3d-9079-c839932d75aa",
              "avatar_url": "http://lol.com/omg50.png",
              "nickname": "test50"
            }
          ],
          "comments": [

          ],
          "task": {
            "client_id": null,
            "id": "9cca7044-80f5-4c78-b393-c1e8a66bdb41",
            "title": "omg",
            "created_at": "2014-04-28T08:56:29.760Z",
            "completed": false,
            "assignee_id": "660403f2-f7ab-478f-9f7b-918ef57c9062",
            "user_id": "e638ac74-871f-4d3d-9079-c839932d75aa",
            "comment_ids": [

            ]
          }
        }
```

### Comments

Every comment fully supports markdown and code highlighting is colored with the beautiful monokai theme.

You can add a comment to a task with the API like this:

```
# POST /comments

+ Request application/json

        {
          "comment": {
            "body": "test",
            "client_id": "1234",
            "task_id": "41ee1cb0-00ed-4c67-8669-cbd2506f8a70"
          }
        }

+ Response 201 application/json; charset=utf-8

        {
          "comment": {
            "client_id": "1234",
            "id": "8eebdd63-3820-4d98-b00a-6475735254a3",
            "body": "test",
            "created_at": "2014-04-28T08:56:29.217Z",
            "task_id": "41ee1cb0-00ed-4c67-8669-cbd2506f8a70",
            "user_id": "0f6ac7e0-f244-4f92-b93a-6924b46161ee"
          }
        }
```

### Leaderboard

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

- Half of the PR points for commenting with `:+1:`, `:thumbsup:`, `:shipit:`

#### Caveats

In order to get points for merging PRs you need to setup a webhook in your repos that points to:

```
https://your.lion.installation.com/api/pull_requests
```

### Hall of Fame

Weekly winners will be placed here.
In order to declare a weekly winner run the `hall_of_fame:declare_weekly_winner` rake task every monday morning.

### Stats

Displayed stats:

- Number of merged PRs
- Number of reviews
- Total number of additions across merged PRs
- Total number of deletions across merged PRs
- Number of completed tasks

### Badges

Coming soon :)
