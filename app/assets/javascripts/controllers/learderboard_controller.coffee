Lion.LeaderboardController = Ember.ArrayController.extend(new Lion.Pusherable('score'),
  sortProperties: ['points']
  sortAscending: false
)
