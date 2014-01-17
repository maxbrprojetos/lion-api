Notdvs.BatcaveRoute = Notdvs.AuthenticatedRoute.extend
  model: ->
    @store.find('task')