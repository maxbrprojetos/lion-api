Notdvs.ScoreController = Ember.ObjectController.extend
  needs: ['leaderboard']
  maximumPoints: Ember.computed.alias('controllers.leaderboard.maximumPoints')

  progressBarStyle: (->
    "width: %@%".fmt(@_progressBarWidth())
  ).property('points', 'maximumPoints')

  _progressBarWidth: ->
    if @get('points') == 0
      0
    else
      (@get('points') / @get('maximumPoints')) * 100
