Notdvs.LocalStorage = Ember.Namespace.create
  getItem: (key) ->
    Ember.Object.create(JSON.parse(window.localStorage.getItem(key)))

  setItem: (key, item) ->
    window.localStorage.setItem(key, JSON.stringify(item))

  removeItem: (key) ->
    window.localStorage.removeItem(key)