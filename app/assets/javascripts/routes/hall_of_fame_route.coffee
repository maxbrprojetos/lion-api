Lion.HallOfFameRoute = Lion.AuthenticatedRoute.extend
  model: ->
    @store.find('weeklyWinning')
