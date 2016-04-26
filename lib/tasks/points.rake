namespace :points do
  task recalculate_points: :environment do
    Rake::Task['points:reset_points'].invoke
    RecalculatePoints.perform_async
  end

  task reset_points: :environment do
    PullRequest.delete_all
    PullRequestReview.delete_all
    Pairing.delete_all
    Score.reset_points
  end
end
