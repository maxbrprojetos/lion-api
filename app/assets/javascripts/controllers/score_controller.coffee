Notdvs.ScoreController = Ember.ObjectController.extend(
  needs: ['leaderboard']
  maximumPoints: Ember.computed.alias('controllers.leaderboard.maximumPoints')

  progressBarWidth: (->
    if @get('points') == 0
      0
    else
      (@get('points') / @get('maximumPoints')) * 100
  ).property('points', 'maximumPoints')

  progressBarStyle: (->
    "width: %@%".fmt(@get('progressBarWidth'))
  ).property('progressBarWidth')
)
