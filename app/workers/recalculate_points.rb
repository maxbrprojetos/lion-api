class RecalculatePoints
  include Sidekiq::Worker

  def perform
    PullRequest.delete_all
    PullRequestReview.delete_all
    Badge.delete_all
    Score.reset_points

    client = User.primary_client
    client.auto_paginate = true

    client.organization_repositories(ENV['ORGANIZATION_NAME']).map(&:full_name).each do |repo|
      client.pull_requests(repo, state: 'closed').each do |pr|
        user = User.where(nickname: pr.user.login).first

        next unless user

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
          number_of_changed_files: pr_data.changed_files,
          merged_at: pr_data.merged_at
        )

        if pull_request.save
          puts "#{repo} #{pr.number} #{pr.user.login} #{pr_data.merged_at} #{'weekly' if pr_data.merged_at && pr_data.merged_at > Time.now.beginning_of_week}"
        end
      end
    end

    TaskCompletion.all.each { |tc| tc.send(:give_points_to_user) }
  end
end
