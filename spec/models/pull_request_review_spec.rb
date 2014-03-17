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

    pull_request_review = PullRequestReview.new(body: ':+1:', user: create(:user), pull_request: pull_request)
    pull_request_review.save!
    pull_request_review.user.points.should eq(pull_request_review.points)
  end
end
