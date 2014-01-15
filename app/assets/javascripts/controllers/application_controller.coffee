Notdvs.ApplicationController = Ember.Controller.extend
  layoutName: 'layouts/application'

  connectLayout: (name) ->
    name = "layouts/#{name}"

    if @get('layoutName') != name
      @set('layoutName', name)