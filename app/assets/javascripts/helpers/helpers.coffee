Ember.Handlebars.registerBoundHelper('formattedDate', (date, format) ->
  moment(date).format(format)
)

Ember.Handlebars.registerBoundHelper('pluralize', (number, options) ->
  single = options.hash['single']
  Ember.assert('pluralize requires a singular string (single)', single)
  plural = options.hash['plural'] || single + 's'

  if number == 1 then single else plural
)
