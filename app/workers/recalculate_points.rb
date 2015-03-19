class RecalculatePoints
  include Sidekiq::Worker

  def perform
    reset_points

    client.organization_repositories(ENV['ORGANIZATION_NAME']).map(&:full_name).each do |repo|
      page = 1

      loop do
        pull_requests = client.pull_requests(repo, state: 'closed', per_page: 100, page: page)

        if pull_requests.present?
          calculate_points_for(pull_requests: pull_requests, repo: repo)
          page += 1
        else
          break
        end
      end
    end

    TaskCompletion.all.each { |tc| tc.send(:give_points_to_user) }
  end

  private

  def calculate_points_for(pull_requests:, repo:)
    pull_requests.each do |pr|
      user = User.where(nickname: pr.user.login).first
      next unless user
      pr_data = pr.rels[:self].get.data
      pull_request = build_pull_request(user: user, pr: pr, pr_data: pr_data, repo: repo)

      if pull_request.save
        puts "#{repo} #{pr.number} #{pr.user.login} #{pr_data.merged_at} #{'weekly' if pr_data.merged_at && pr_data.merged_at > Time.now.beginning_of_week}"
      end
    end
  end

  def reset_points
    PullRequest.delete_all
    PullRequestReview.delete_all
    Badge.delete_all
    Score.reset_points
  end

  def client
    @client ||= User.primary_client
  end

  def build_pull_request(user:, pr:, pr_data:, repo:)
    PullRequest.new(
      user: user,
      merged: pr.merged_at.present?,
      number: pr.number,
      base_repo_full_name: repo,
      number_of_comments: pr_data.comments,
      number_of_commits: pr_data.commits,
      number_of_additions: pr_data.additions,
      number_of_deletions: pr_data.deletions,
      number_of_changed_files: pr_data.changed_files,
      merged_at: pr_data.merged_at
    )
  end
end
