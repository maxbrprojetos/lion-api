Notdvs.UserStatsController = Ember.ObjectController.extend(
  needs: ['leaderboard']
  maximumPoints: Ember.computed.alias('controllers.leaderboard.maximumPoints')

  progressBarWidth: (->
    if @get('points') == 0
      "width: 0%"
    else
      "width: #{(@get('points') / @get('maximumPoints')) * 100}%"
  ).property('points', 'maximumPoints')
)
