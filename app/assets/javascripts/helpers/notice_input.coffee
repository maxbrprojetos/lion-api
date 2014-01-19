Notdvs.NoticeInput = (input) ->
  regexp: /app:([^\s]+)/

  title: ->
    input.replace(@regexp, '').trim()

  app: ->
    if @regexp.test(input)
      $.trim(@regexp.exec(input)[1])
    else
      ''