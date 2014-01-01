#= require spec_helper

describe 'Integration test for index route', ->
  beforeEach ->
    Ember.run -> testHelper.lookup('router').transitionTo('index')

  it 'shows Pistachio', ->
    server.respondWith('GET', '/api/notices', [200, { 'Content-Type': 'application/json' }, '{ "notices": [] }'])

    Ember.run.next ->
      $('p').text().should.equal('Pistachio')
