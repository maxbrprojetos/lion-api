Notdvs.LeaderboardController = Ember.ArrayController.extend(new Notdvs.Pusherable('score'),
  sortProperties: ['points']
  sortAscending: false

  points: Ember.computed.mapBy('content', 'points')
  maximumPoints: Ember.computed.max('points')
)
