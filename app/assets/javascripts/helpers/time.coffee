Ember.Handlebars.registerBoundHelper('formattedDate', (date, format) ->
  return moment(date).format(format)
)
