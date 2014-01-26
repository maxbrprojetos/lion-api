Notdvs.ApplicationController = Ember.Controller.extend
  needs: ['currentUser']
  currentUserBinding: 'controllers.currentUser'
  layoutName: 'layouts/application'

  connectLayout: (name) ->
    name = "layouts/#{name}"

    if @get('layoutName') != name
      @set('layoutName', name)