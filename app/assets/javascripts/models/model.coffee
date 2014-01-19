Notdvs.Model = DS.Model.extend
  createdAt: DS.attr('date', defaultValue: -> new Date())
  clientId: DS.attr('string')