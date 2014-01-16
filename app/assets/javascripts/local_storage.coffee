Notdvs.LocalStorage = Ember.Namespace.create
  getItem: (item) ->
    Ember.Object.create(JSON.parse(window.localStorage.getItem(item)))

  setItem: (key, item) ->
    window.localStorage.setItem(key, JSON.stringify(item))