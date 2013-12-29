Notdvs.Notice = DS.Model.extend
  title: DS.attr('string')
  created_at: DS.attr('date')
  client_id: DS.attr('string')

  ranking: (->
    @get('client_id') || @get('created_at').getTime().toString()
  ).property('client_id', 'created_at')