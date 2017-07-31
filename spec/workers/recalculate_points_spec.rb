require 'spec_helper'

describe RecalculatePoints do
  describe "#perform" do
    let(:user) { create(:user) }
    let(:paired_user) { create(:user) }
    let(:reviewer) { create(:user) }
    let(:repo_name) { "#{user.nickname}/#{Faker::Lorem.word}" }
    let(:params) do
      {
        user: user,
        base_repo_full_name: repo_name,
        body: "#{Faker::Lorem.sentence} I paired with @#{paired_user.nickname}",
        number: Faker::Number.number(3).to_i,
        merged_at: "#{Time.new(2016, 1, 2)}",
        number_of_comments: Faker::Number.number(2).to_i,
        number_of_commits: Faker::Number.number(2).to_i,
        number_of_additions: Faker::Number.number(2).to_i,
        number_of_deletions: Faker::Number.number(2).to_i,
        number_of_changed_files: Faker::Number.number(2).to_i
      }
    end
    let(:client_double) do
      double("GlobalClient",
        rate_limit: { remaining: 1000 }, rate_limit!: { remaining: 1000 })
    end
    let(:pr_page) do
      [
        double(
          user: double(login: params[:user].nickname),
          base: double(repo: double(full_name: params[:base_repo_full_name])),
          body: params[:body],
          number: params[:number],
          rels: { self: double(get: double(
            data: double(
              merged_at: params[:merged_at],
              comments: params[:number_of_comments],
              commits: params[:number_of_commits],
              additions: params[:number_of_additions],
              deletions: params[:number_of_deletions],
              changed_files: params[:number_of_changed_files],
            )
          ))}
        )
      ]
    end

    before :each do
      allow_any_instance_of(PullRequest).to receive(:reviews)
        .and_return([
          double(user: double(login: reviewer.nickname), body: 'LGTM :+1:', state: PullRequestReview::APPROVAL_STATE)
        ])
    end

    it "assigns all points" do
      allow(User).to receive(:global_client).and_return(client_double)
      allow(User).to receive(:current_client_index=).with(0)
      expect(client_double).to receive(:organization_repositories)
        .and_return([double(full_name: repo_name)], [])
      expect(client_double).to receive(:pull_requests).and_return(pr_page, [])

      described_class.new.perform

      expect(PullRequest.count).to eql 1
      expect(PullRequestReview.count).to eql 1
      expect(Pairing.count).to eql 2

      expect(Score.where(user_id: user.id).first.points).to eql 5
      expect(Score.where(user_id: paired_user.id).first.points).to eql 5
      expect(Score.where(user_id: reviewer.id).first.points).to eql 5
    end
  end
end
