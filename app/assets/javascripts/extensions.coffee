unless String.linkify
  String::linkify = ->
    # http://, https://, ftp://
    urlPattern = /((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)/

    # Email addresses
    emailAddressPattern = /\w+@[a-zA-Z_]+?(?:\.[a-zA-Z]{2,6})+/g
    this
      .replace(urlPattern, "<a target=\"_blank\" href=\"$&\">$&</a>")
      .replace(emailAddressPattern, "<a href=\"mailto:$&\">$&</a>")
