Lion.StatsController = Ember.ArrayController.extend
  pullRequestsSorting: ['pullRequestsCount:desc']
  additionsSorting: ['numberOfAdditions:desc']
  deletionsSorting: ['numberOfDeletions:desc']
  reviewsSorting: ['pullRequestReviewsCount:desc']
  completedTasksSorting: ['completedTasksCount:desc']
  pullRequestStats: Ember.computed.sort('content', 'pullRequestsSorting')
  additionStats: Ember.computed.sort('content', 'additionsSorting')
  deletionStats: Ember.computed.sort('content', 'deletionsSorting')
  reviewStats: Ember.computed.sort('content', 'reviewsSorting')
  completedTasksStats: Ember.computed.sort('content', 'completedTasksSorting')
