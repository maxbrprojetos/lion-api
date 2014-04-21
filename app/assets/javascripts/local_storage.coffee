Lion.LocalStorage = Ember.Namespace.create
  getItem: (key) ->
    item = window.localStorage.getItem(key)

    if item != 'undefined'
      JSON.parse(item)
    else
      null

  setItem: (key, item) ->
    window.localStorage.setItem(key, JSON.stringify(item))

  removeItem: (key) ->
    window.localStorage.removeItem(key)
