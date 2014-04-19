Lion.StatsRoute = Lion.AuthenticatedRoute.extend
  model: ->
    @store.find('stats')

