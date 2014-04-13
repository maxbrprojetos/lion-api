Ember.Inflector.inflector.uncountable('stats');

Lion.User = DS.Model.extend
  nickname: DS.attr('string')
  avatarUrl: DS.attr('string')

  githubUrl: (->
    "https://github.com/#{@get('nickname')}"
  ).property('nickname')

Lion.TaskCompletion = DS.Model.extend
  user: DS.belongsTo('user')
  task: DS.belongsTo('task')

Lion.Score = DS.Model.extend
  points: DS.attr('number')
  user: DS.belongsTo('user')

Lion.WeeklyWinning = DS.Model.extend
  startDate: DS.attr('date')
  winner: DS.belongsTo('user')
  points: DS.attr('number')

Lion.Stats = Lion.User.extend
  pullRequestsCount: DS.attr('number')
  numberOfAdditions: DS.attr('number')
  numberOfDeletions: DS.attr('number')
  pullRequestReviewsCount: DS.attr('number')
  tasksCount: DS.attr('number')
