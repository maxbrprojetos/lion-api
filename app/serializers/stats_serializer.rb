class StatsSerializer < UserSerializer
  attributes :pull_requests_count, :number_of_additions, :number_of_deletions, :pull_request_reviews_count, :completed_tasks_count, :badges_count

  def pull_requests_count
    object.pull_requests.count
  end

  def pull_request_reviews_count
    object.pull_request_reviews.count
  end

  def number_of_additions
    object.pull_requests.sum(:number_of_additions)
  end

  def number_of_deletions
    object.pull_requests.sum(:number_of_deletions)
  end

  def completed_tasks_count
    object.task_completions.count
  end

  def badges_count
    object.badges.count
  end
end
