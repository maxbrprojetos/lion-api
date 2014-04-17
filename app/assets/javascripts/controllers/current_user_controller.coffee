Lion.CurrentUserController = Ember.ObjectController.extend
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
      currentUser = Lion.LocalStorage.getItem('currentUser')

      if !Ember.isEmpty(currentUser)
        @store.push('user', currentUser)
        @store.getById('user', currentUser.id)
      else
        @sync()
  ).property()

  contentDidChange: (->
    Lion.LocalStorage.setItem('currentUser', @get('content')?.toJSON({ includeId: true }))
  ).observes('content')
