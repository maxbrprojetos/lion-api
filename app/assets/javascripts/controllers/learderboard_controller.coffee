Lion.LeaderboardController = Ember.ArrayController.extend(new Ember.Pushable('score'),
  sortProperties: ['points']
  sortAscending: false
)
