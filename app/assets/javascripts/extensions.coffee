unless String.linkify
  String::linkify = ->
    # http://, https://, ftp://
    urlPattern = /\b(?:https?|ftp):\/\/[a-z0-9-+&@#\/%?=~_|!:,.;]*[a-z0-9-+&@#\/%=~_|]/g

    # www. sans http:// or https://
    pseudoUrlPattern = /(^|[^\/])(www\.[\S]+(\b|$))/g

    # Email addresses
    emailAddressPattern = /\w+@[a-zA-Z_]+?(?:\.[a-zA-Z]{2,6})+/g
    this
      .replace(urlPattern, "<a target=\"_blank\" href=\"$&\">$&</a>")
      .replace(pseudoUrlPattern, "$1<a target=\"_blank\" href=\"http://$2\">$2</a>")
      .replace(emailAddressPattern, "<a href=\"mailto:$&\">$&</a>")
