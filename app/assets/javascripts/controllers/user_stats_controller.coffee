Notdvs.UserStatsController = Ember.ObjectController.extend(
  needs: ['leaderboard']

  progressBarWidth: (->
    "width: #{(@get('points') / @get('controllers.leaderboard.maximumPoints')) * 100}%"
  ).property('points')
)
