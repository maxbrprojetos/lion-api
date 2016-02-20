require 'spec_helper'

describe PointsMarshaller do
  describe "#marshall" do
    let(:user) { create(:user) }
    let(:paired_user) { create(:user) }
    let(:reviewer) { create(:user) }
    let(:params) do
      {
        user: user,
        base_repo_full_name: "#{Faker::Internet.user_name}/#{Faker::Lorem.word}",
        body: Faker::Lorem.sentence,
        number: Faker::Number.number(3),
        merged_at: Time.zone.now - 1.day,
        number_of_comments: Faker::Number.number(2),
        number_of_commits: Faker::Number.number(2),
        number_of_additions: Faker::Number.number(2),
        number_of_deletions: Faker::Number.number(2),
        number_of_changed_files: Faker::Number.number(2)
      }
    end

    it "creates a pull request" do
      allow_any_instance_of(PullRequest).to receive(:comments).and_return([])
      pull_request = described_class.new(data: params).marshall

      expect(pull_request.persisted?).to eq true
    end

    it "creates a pull request review and scores it" do
      allow_any_instance_of(PullRequest).to receive(:comments)
        .and_return([
          double(user: double(login: reviewer.nickname), body: "LGTM :+1:")
          ])
      pull_request = described_class.new(data: params).marshall

      pull_request_reviewers = pull_request.pull_request_reviews.pluck(:user_id)
      expect(pull_request_reviewers.count).to eq 1

      review_points = Score.where(user: pull_request_reviewers)
        .all_time.pluck(:points)
      expect(review_points.all?{ |p| p == pull_request.points / 2 }).to eq true
    end

    it "creates and scores pairings" do
      allow_any_instance_of(PullRequest).to receive(:comments).and_return([])
      params[:body] += "I paired with @#{paired_user.nickname}"
      pull_request = described_class.new(data: params).marshall
      
      pairers = pull_request.pairings.pluck(:user_id)
      expect(pairers.count).to eq 2

      pair_points = Score.where(user: pairers).all_time.pluck(:points)
      expect(pair_points.sum).to eq pull_request.points
      expect(pair_points.all?{ |p| p == pull_request.points / 2 }).to eq true
    end
  end
end
