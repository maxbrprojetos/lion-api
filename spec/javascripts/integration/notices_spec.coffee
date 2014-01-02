#= require spec_helper

describe 'Notices - Integration', ->
  beforeEach ->
    visit('/')

  it 'shows Pistachio', ->
    find('.status-circle p').text().should.equal('Pistachio')

  it 'adds a Notice to the list', ->
    fillIn('input[type="text"]', 'test')
    .click('input[type="submit"]')
    .then ->
      find('.title').text().should.equal('test')

  it 'deletes a Notice', ->
    Ember.run ->
      notice = Notdvs.lookup('store:main').createRecord('notice', { title: 'test' })
      notice.save().then ->
        click('.close').then ->
          find('.title').length.should.equal(0)