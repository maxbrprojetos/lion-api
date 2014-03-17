task recalculate_points: :environment do
  PullRequest.destroy_all
  User.update_all(points: 0)

  Octokit.auto_paginate = true

  client = User.first.github_client

  [
    'alphasights/pistachio',
    'alphasights/notdvs',
    'alphasights/bee',
    'alphasights/brazil',
    'alphasights/octopus',
    'alphasights/candlenut'
  ].each do |repo|
    client.pull_requests(repo, state: 'closed').each do |pr|
      user = User.where(nickname: pr.user.login).first

      next unless user

      puts "#{repo} #{pr.number}"

      pr_data = pr.rels[:self].get.data

      pull_request = PullRequest.new(
        user: user,
        merged: true,
        number: pr.number,
        base_repo_full_name: repo,
        number_of_comments: pr_data.comments,
        number_of_commits: pr_data.commits,
        number_of_additions: pr_data.additions,
        number_of_deletions: pr_data.deletions,
        number_of_changed_files: pr_data.changed_files
      )

      puts pull_request.errors.full_messages unless pull_request.save
    end
  end

  TaskCompletion.all.each { |tc| tc.send(:give_points_to_user) }
end

task update_points_system: :environment do
  User.update_all(points: 0)
  PullRequest.all.each { |pr| pr.send(:give_points_to_user) }
  PullRequestReview.all.each { |prr| prr.send(:give_points_to_user) }
  TaskCompletion.all.each { |tc| pr.send(:give_points_to_user) }
end
