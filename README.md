# Lion API

## What sorcery is this?

Lion is a dashboard for developers written with Ember and Rails.
It rewards developers when they get shit done®.

This is the API. [Here](https://github.com/alphasights/lion) you can find the web client.

## Contributing

- Fork this repository
- `cp .example-env .env`
- Update the `GITHUB_APP_ID`, `GITHUB_APP_SECRET` and `USERS` variables to relevant values.
- `bundle install`
- `bundle exec thor db:capture`
- `bundle exec thor db:sync`

## Running
- `rails server`

## Testing
- `bundle exec rspec`

## Dependencies

- Postgresql
- Flowdock
- Pusher
- Github

## Features

All the features presented here have a summary page which updates live.
Every action can be either performed via the interface or using the RESTful API.

### Leaderboard

There are currently two leaderboards: weekly and all time. The top person in the ladder will always have their bar full, and the other bars are calculated based on the top one.

Points are given according to the following rules.

#### Rules

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

### Badges

Adding a comment with one of the special emojis will increase the points given to the PR creator:

- `:100:` 20 points
- `:trophy:` 10 points
- `:dancer:` or `:star:` 5 points
