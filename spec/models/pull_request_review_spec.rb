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
end
