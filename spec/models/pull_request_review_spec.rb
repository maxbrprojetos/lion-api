# == Schema Information
#
# Table name: pull_request_reviews
#
#  id              :integer          not null, primary key
#  user_id         :uuid
#  pull_request_id :uuid
#  body            :text
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe PullRequestReview do
  describe '#body' do
    it 'is valid only if it contains positive signs' do
      pull_request_review = PullRequestReview.new(body: 'test')
      pull_request_review.valid?

      expect(pull_request_review.errors.full_messages).to include('Body must contain positive signs')

      [':+1:', ':shipit:', ':thumbsup:'].each do |message|
        pull_request_review.body = message
        pull_request_review.valid?

        expect(pull_request_review.errors.full_messages).not_to include('Body must contain positive signs')
      end
    end
  end

  describe '#points' do
    it 'returns a fraction of pr points' do
      pull_request = build(:pull_request)
      pull_request_review = PullRequestReview.new(body: 'test', pull_request: pull_request)
      allow(pull_request).to receive(:points).and_return(130)
      expect(pull_request_review.points).to eq(pull_request.points / 2)
    end
  end

  it 'gives points to the user' do
    pull_request = build(:pull_request)
    # TODO: have this stub inside the factory itself
    allow(pull_request).to receive(:comments).and_return([])
    pull_request.save!

    user = create(:user)
    pull_request_review = PullRequestReview.new(body: ':+1:', user: user, pull_request: pull_request)
    pull_request_review.save!

    score = Score.where(user: user).all_time.first
    expect(score.points).to eq(pull_request_review.points)
  end

  context 'when the pull request is more than one week old' do
    it "doesn't give points to the user for the weekly score" do
      pull_request = build(:pull_request, merged_at: 1.month.ago)

      allow(pull_request).to receive(:comments).and_return([])
      pull_request.save!

      user = create(:user)
      pull_request_review = PullRequestReview.new(body: ':+1:', user: user, pull_request: pull_request)
      pull_request_review.save!

      expect(Score.where(user: user).weekly.first).not_to be_present
    end
  end
end
