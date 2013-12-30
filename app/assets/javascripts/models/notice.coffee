Notdvs.Notice = DS.Model.extend
  title: DS.attr('string')
  created_at: DS.attr('date')
  client_id: DS.attr('string')
  type: DS.attr('string', { defaultValue: 'warning' })

  ranking: (->
    # check created_at first so records coming from pusher cannot alter ordering
    # by providing a different kind of client_id
    @get('created_at')?.getTime().toString() || @get('client_id')
  ).property('client_id', 'created_at')

Notdvs.NoticeSerializer = DS.ActiveModelSerializer.extend
  serialize: (record, options) ->
    json = this._super.apply(this, arguments)
    delete json.created_at
    json