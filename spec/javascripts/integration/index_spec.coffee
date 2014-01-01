#= require spec_helper

describe 'Index Route - Integration', ->
  it 'shows Pistachio', ->
    server.respondWith('GET', '/api/notices', [200, { 'Content-Type': 'application/json' }, '{ "notices": [] }'])

    visit('/').then ->
      find('p').text().should.equal('Pistachio')
