Notdvs.Store = DS.Store.extend
  # pushPayload doesn't work with single records
  pushRecord: (type, record) ->
    key = type.underscore().pluralize()
    payload = {}
    payload[key] = [record]
    @pushPayload type, payload
    @getById type, record.id

Notdvs.ApplicationAdapter = DS.RESTAdapter.reopen
  namespace: 'api'

Notdvs.ApplicationSerializer = DS.ActiveModelSerializer.extend
  serialize: (record, options) ->
    json = @_super.apply(this, arguments)
    delete json.created_at
    json

Notdvs.Model = DS.Model.extend()