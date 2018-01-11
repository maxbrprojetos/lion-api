namespace :data_cleanup do
  desc "a task to remove old style scores without associated prs or reviews"
  task remove_scores: :environment do
    unattached_scores = Score.without_pr.without_review
    puts "Found #{ActionController::Base.helpers.pluralize(unattached_scores.count, 'unattached score')}"
    puts "Removing unattached scores..."
    unattached_scores.destroy_all
    puts "Done"
    puts "Found #{ActionController::Base.helpers.pluralize(unattached_scores.count, 'unattached score')}"
  end
end
