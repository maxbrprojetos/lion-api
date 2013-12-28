Notdvs.Store = DS.Store.extend
  pushRecord: (type, record) ->
    key = type.underscore().pluralize()
    payload = {}
    payload[key] = [record]
    @pushPayload type, payload
    @getById type, record.id

Notdvs.ApplicationAdapter = DS.RESTAdapter.reopen
  namespace: 'api'

Notdvs.ApplicationSerializer = DS.ActiveModelSerializer

Notdvs.Model = DS.Model.extend()