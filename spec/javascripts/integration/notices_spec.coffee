#= require spec_helper

describe 'Notices - Integration', ->
  beforeEach ->
    visit('/')

  it 'shows Ok status', ->
    find('.status p').text().should.equal('ok')

  it 'adds a Notice to the list', ->
    fillIn('input[type="text"]', 'test')
    click('input[type="submit"]')
    andThen ->
      find('.title').text().should.equal('test')

  it 'deletes a Notice', ->
    fillIn('input[type="text"]', 'test')
    click('input[type="submit"]')
    click('.close')
    andThen ->
      find('.closing .title').length.should.equal(1)

  it 'adds a Notice with an app', ->
    fillIn('input[type="text"]', 'app:lol test')
    click('input[type="submit"]')
    andThen ->
      find('.title').text().should.equal('test')
      find('.app').text().should.equal('lol')
      find('.status p').text().should.equal('lol')