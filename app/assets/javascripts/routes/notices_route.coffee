Notdvs.NoticesRoute = Notdvs.AuthenticatedRoute.extend
  model: ->
    @store.find('notice')