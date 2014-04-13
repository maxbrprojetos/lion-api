Lion.StatsController = Ember.ArrayController.extend
  pullRequestsSorting: ['pullRequestsCount:desc']
  additionsSorting: ['numberOfAdditions:desc']
  deletionsSorting: ['numberOfDeletions:desc']
  reviewsSorting: ['pullRequestReviewsCount:desc']
  tasksSorting: ['tasksCount:desc']
  pullRequestStats: Ember.computed.sort('content', 'pullRequestsSorting')
  additionStats: Ember.computed.sort('content', 'additionsSorting')
  deletionStats: Ember.computed.sort('content', 'deletionsSorting')
  reviewStats: Ember.computed.sort('content', 'reviewsSorting')
  tasksStats: Ember.computed.sort('content', 'tasksSorting')
