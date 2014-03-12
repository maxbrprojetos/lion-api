task recalculate_points: :environment do
  PullRequest.delete_all
  User.update_all(points: 0)

  Octokit.auto_paginate = true

  client = User.first.github_client

  ['alphasights/pistachio', 'alphasights/notdvs', 'alphasights/bee', 'alphasights/brazil', 'alphasights/octopus'].each do |repo|
    client.pull_requests(repo, state: 'closed').each do |pr|
      puts "#{repo} #{pr.number}"
      user = User.where(nickname: pr.user.login).first

      next unless user

      PullRequest.create!(user: user, merged: 'true', number: pr.number, base_repo_full_name: pr.base.repo.full_name)
    end
  end

  TaskCompletion.all.each { |tc| tc.user && tc.user.increment_points_by(TaskCompletion.points) }
end
