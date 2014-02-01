#= require spec_helper

describe 'Tasks - Integration', ->
  beforeEach ->
    visit('/tasks')

  it 'adds a Task to the list', ->
    fillIn('input[type="text"]', 'test')
    click('input[type="submit"]')
    andThen ->
      find('.title').text().should.equal('test')

  it 'deletes a Task', ->
    fillIn('input[type="text"]', 'test')
    click('input[type="submit"]')
    click('.destroy')
    andThen ->
      find('.title').length.should.equal(0)

  it 'updates a Task', ->
    fillIn('input[type="text"]', 'test')
    click('input[type="submit"]')
    click('.actions .edit')
    fillIn('input.edit', 'omg')
    click('.actions .edit')
    andThen ->
      find('.title').text().should.equal('asdsadsadasdas')