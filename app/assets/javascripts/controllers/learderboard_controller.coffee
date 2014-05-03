Lion.LeaderboardController = Ember.ArrayController.extend(new Lion.Pushable('score'),
  sortProperties: ['points']
  sortAscending: false
)
