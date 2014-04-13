Lion.StatsController = Ember.ArrayController.extend
  pullRequestsSorting: ['pullRequestsCount']
  additionsSorting: ['numberOfAdditions']
  deletionsSorting: ['numberOfDeletions']
  reviewsSorting: ['pullRequestReviewsCount']
  pullRequestStats: Ember.computed.sort('content', 'pullRequestsSorting')
  additionStats: Ember.computed.sort('content', 'additionsSorting')
  deletionStats: Ember.computed.sort('content', 'deletionsSorting')
  reviewStats: Ember.computed.sort('content', 'reviewsSorting')
