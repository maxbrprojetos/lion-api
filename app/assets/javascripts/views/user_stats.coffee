Lion.UserStats = Ember.CollectionView.extend(Ember.SortableMixin,
  tagName: 'ul'
  classNames: ['stats']

  pointsPropertyDidChange: (->
    Ember.defineProperty(this, 'points',
      Ember.computed.mapBy('content', @get('pointsProperty'))
    )
  ).observes('pointsProperty').on('init')

  maximumPoints: Ember.computed.max('points')

  itemViewClass: Ember.View.extend
    templateName: 'user_stats_item'

    progressBarStyle: (->
      "width: %@%".fmt(@progressBarWidth())
    ).property('points', 'parentView.maximumPoints')

    progressBarWidth: ->
      if @get('points') == 0
        0
      else
        (@get('points') / @get('parentView.maximumPoints')) * 100

    pointsPropertyDidChange: (->
      Ember.defineProperty(this, 'points',
        Ember.computed.alias("content.#{@get('parentView.pointsProperty')}")
      )
    ).observes('parentView.pointsProperty').on('init')

    avatarUrlPropertyDidChange: (->
      Ember.defineProperty(this, 'avatarUrl',
        Ember.computed.alias("content.#{@get('parentView.avatarUrlProperty')}")
      )
    ).observes('parentView.avatarUrlProperty').on('init')
)
