module 'Ember.js Library',
  setup: ->
    Ember.run -> Notdvs.advanceReadiness()

  teardown: ->
    Notdvs.reset()

test 'Check HTML is returned', ->
  visit('/').then ->
    ok exists('p:contains("Pistachio")')