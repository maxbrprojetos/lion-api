Notdvs.CurrentUserController = Ember.ObjectController.extend
  sync: ->
    $.getJSON("#{location.protocol}//#{location.host}/api/users/me").then((data) =>
      @store.pushPayload(data)
      @set('content', @store.getById('user', data.user.id))
    )

  logout: ->
    @set('content', null)

  content: (->
    content = @_super.apply(this, arguments)
    return content if content

    currentUser = Notdvs.LocalStorage.getItem('currentUser')

    # getter
    if arguments.length == 1
      if !Ember.isEmpty(currentUser)
        @set('content', @store.push('user', currentUser))
      else
        @sync()
  ).property()

  contentDidChange: (->
    Notdvs.LocalStorage.setItem('currentUser', @get('content')?.toJSON({ includeId: true }))
  ).observes('content')