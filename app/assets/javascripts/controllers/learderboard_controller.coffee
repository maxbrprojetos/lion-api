Notdvs.LeaderboardController = Ember.ArrayController.extend(new Notdvs.Pusherable('user'),
  sortProperties: ['points']
  sortAscending: false

  points: Ember.computed.mapBy('content', 'points')
  maximumPoints: Ember.computed.max('points')
)
