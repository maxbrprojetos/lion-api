Notdvs.LeaderboardController = Ember.ArrayController.extend(new Notdvs.Pusherable('user'),
  points: Ember.computed.mapBy('content', 'points')
  maximumPoints: Ember.computed.max('points')
)
