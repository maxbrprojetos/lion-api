Notdvs.CurrentUserController = Ember.ObjectController.extend
  sync: ->
    $.getJSON("#{location.protocol}//#{location.host}/api/users/me").then((data) =>
      @store.pushPayload(data)
      @set('content', @store.getById('user', data.user.id))
    )

  logout: ->
    @set('content', null)

  content: (->
    if arguments.length > 1
      # setter
      @_super.apply(this, arguments)
    else
      # getter
      currentUser = Notdvs.LocalStorage.getItem('currentUser')

      if !Ember.isEmpty(currentUser)
        @set('content', @store.push('user', currentUser))
      else
        @sync()

  ).property()

  contentDidChange: (->
    Notdvs.LocalStorage.setItem('currentUser', @get('content')?.toJSON({ includeId: true }))
  ).observes('content')