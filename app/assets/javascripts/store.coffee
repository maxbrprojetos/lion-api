Lion.ApplicationStore = DS.Store.extend()

Lion.ApplicationAdapter = DS.ActiveModelAdapter.reopen
  namespace: 'api'

Lion.ApplicationSerializer = DS.ActiveModelSerializer.extend
  serialize: (record, options) ->
    json = @_super.apply(this, arguments)
    delete json.created_at
    json

  typeForRoot: (root) ->
    root = 'user' if root == 'winner' || root == 'winners'
    @_super(root)
