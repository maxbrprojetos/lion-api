require 'spec_helper'

describe Score do
  it 'has valid factory' do
    expect(build(:score)).to be_valid
    expect(build(:score_for_review)).to be_valid
  end

  it 'is invalid if there is no user' do
    expect(build(:score, user: nil)).to_not be_valid
    expect(build(:score_for_review, user: nil)).to_not be_valid
  end

  it 'is invalid if there is no pr or review' do
    expect(build(:score, pull_request: nil)).to_not be_valid
    expect(build(:score_for_review, pull_request_review: nil)).to_not be_valid
  end

  describe '.weekly_high_score' do
    let!(:today) { DateTime.now }
    let!(:last_week) { today.weeks_ago(1) }
    let(:jay) { create(:user, name: 'jay') }
    let(:jim) { create(:user, name: 'jim') }
    let(:joe) { create(:user, name: 'joe') }

    let(:jay_pr) { create(:pull_request, user: jay, merged_at: today, number_of_additions: 15, number_of_deletions: 20) }
    let(:jim_pr) { create(:pull_request, user: jim, merged_at: last_week, number_of_additions: 5, number_of_deletions: 2) }
    let(:joe_pr) { create(:pull_request, user: joe, merged_at: last_week, number_of_additions: 50, number_of_deletions: 200) }

    let(:jay_review) { create(:pull_request_review, user: jay, pull_request: jim_pr) }
    let(:jim_review) { create(:pull_request_review, user: jim, pull_request: joe_pr) }
    let(:joe_review) { create(:pull_request_review, user: joe, pull_request: jay_pr) }

    before do
      jay.scores.create!(pull_request: jay_pr, points: jay_pr.points, created_at: jay_pr.merged_at)
      jim.scores.create!(pull_request: jim_pr, points: jim_pr.points, created_at: jim_pr.merged_at)
      joe.scores.create!(pull_request: joe_pr, points: joe_pr.points, created_at: joe_pr.merged_at)
      jay.scores.create!(pull_request_review: jay_review, points: jay_review.pull_request.points / 2, created_at: jay_review.pull_request.merged_at)
      jim.scores.create!(pull_request_review: jim_review, points: jim_review.pull_request.points / 2, created_at: jim_review.pull_request.merged_at)
      joe.scores.create!(pull_request_review: joe_review, points: joe_review.pull_request.points / 2, created_at: joe_review.pull_request.merged_at)
    end

    context 'for current week' do
      it 'only considers points from the current week' do
        expect(described_class.weekly_high_score).to eq [
          jay.id,
          jay_pr.points
        ]
      end
    end

    context 'for a past week' do
      it 'only considers points for that past week' do
        expect(described_class.weekly_high_score(last_week)).to eq [
          joe.id,
          joe_pr.points
        ]
      end
    end
  end
end
