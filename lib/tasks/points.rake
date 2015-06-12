task recalculate_points: :environment do
  RecalculatePoints.perform_async
end

task update_points_system: :environment do
  Score.reset_points
  PullRequest.all.each { |pr| pr.send(:give_points_to_user) }
  PullRequestReview.all.each { |prr| prr.send(:give_points_to_user) }
  Badge.all.each { |b| b.send(:give_points_to_user) }
  TaskCompletion.all.each { |tc| tc.send(:give_points_to_user) }
end
