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

      pull_request_review.errors.full_messages.should include('Body must contain positive signs')

      pull_request_review.body = ':+1:'
      pull_request_review.valid?

      pull_request_review.errors.full_messages.should_not include('Body must contain positive signs')
    end
  end

  it 'gives points to the user' do
    pull_request = build(:pull_request)
    # TODO: have this stub inside the factory itself
    pull_request.stub(comments: [])
    pull_request.save!

    user = create(:user)
    pull_request_review = PullRequestReview.new(body: ':+1:', user: user, pull_request: pull_request)
    pull_request_review.save!

    score = Score.where(user: user).all_time.first
    score.points.should eq(pull_request_review.points)
  end

  context 'when the pull request is more than one week old' do
    it "doesn't give points to the user for the weekly score" do
      pull_request = build(:pull_request, merged_at: 1.month.ago)

      pull_request.stub(comments: [])
      pull_request.save!

      user = create(:user)
      pull_request_review = PullRequestReview.new(body: ':+1:', user: user, pull_request: pull_request)
      pull_request_review.save!

      Score.where(user: user).weekly.first.should_not be_present
    end
  end
end
