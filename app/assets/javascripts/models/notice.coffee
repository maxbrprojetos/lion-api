Notdvs.Notice = DS.Model.extend
  title: DS.attr('string')
  created_at: DS.attr('date')
  client_id: DS.attr('string')

  ranking: (->
    # check created_at first so records coming from pusher cannot alter ordering
    # by providing their own client id
    @get('created_at').getTime().toString() || @get('client_id')
  ).property('client_id', 'created_at')