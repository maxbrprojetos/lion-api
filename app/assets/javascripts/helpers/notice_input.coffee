class Notdvs.NoticeInput
  regexp: /app:(.*)\s/

  constructor: (@input) ->

  title: ->
    @input.replace(@regexp, '')

  app: ->
    if @regexp.test(@input)
      $.trim(@regexp.exec(@input)[1])
    else
      ''