Lion.LeaderboardController = Ember.ArrayController.extend(new Lion.Pusherable('score'),
  sortProperties: ['points']
  sortAscending: false

  points: Ember.computed.mapBy('content', 'points')
  maximumPoints: Ember.computed.max('points')
)
