Lion.LocalStorage = Ember.Namespace.create
  getItem: (key) ->
    unless window.localStorage.getItem(key) != undefined
      JSON.parse(window.localStorage.getItem(key))

  setItem: (key, item) ->
    window.localStorage.setItem(key, JSON.stringify(item))

  removeItem: (key) ->
    window.localStorage.removeItem(key)
