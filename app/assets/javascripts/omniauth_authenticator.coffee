Lion.OmniauthAuthenticator = Ember.SimpleAuth.Authenticators.OAuth2.extend
  authenticate: ->
    new Ember.RSVP.Promise((resolve, reject) ->
      window.open(
        "#{location.protocol}//#{location.host}/auth/github", '_blank',
        'menubar=no,status=no,height=400,width=800'
      )

      $(window).on('loginSucceeded', (event, user) ->
        resolve({ access_token: user.access_token })
      )

      $(window).on('loginFailed', (event, errors) ->
        reject(errors)
      )
    )
