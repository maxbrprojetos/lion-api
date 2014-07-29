# == Schema Information
#
# Table name: badges
#
#  id              :integer          not null, primary key
#  user_id         :uuid
#  pull_request_id :uuid
#  body            :text
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Badge do
  describe '#body' do
    it 'is valid only if it contains one of the special badges' do
      badge = Badge.new(body: 'test')
      badge.valid?

      expect(badge.errors.full_messages).to include('Body must contain a special badge')

      [':trophy:', ':star:', ':dancer:', ':100:'].each do |comment_body|
        badge.body = comment_body
        badge.valid?

        expect(badge.errors.full_messages).not_to include('Body must contain a special badge')
      end
    end
  end

  describe '#points' do
    it 'returns 20 points for the 100 badge' do
      pull_request = build(:pull_request)
      badge = Badge.new(body: ':100:', pull_request: pull_request)
      pull_request.stub(points: 130)
      expect(badge.points).to eq(20)
    end

    it 'returns 10 points for the trophy badge' do
      pull_request = build(:pull_request)
      badge = Badge.new(body: ':trophy:', pull_request: pull_request)
      pull_request.stub(points: 130)
      expect(badge.points).to eq(10)
    end

    it 'returns 5 points for the star badge' do
      pull_request = build(:pull_request)
      badge = Badge.new(body: ':star:', pull_request: pull_request)
      pull_request.stub(points: 130)
      expect(badge.points).to eq(5)
    end

    it 'returns 5 points for the dancer badge' do
      pull_request = build(:pull_request)
      badge = Badge.new(body: ':dancer:', pull_request: pull_request)
      pull_request.stub(points: 130)
      expect(badge.points).to eq(5)
    end
  end

  it 'gives points to the user who created the PR, not the reviewer' do
    pull_request_creator = create(:user)
    pull_request = build(:pull_request, user: pull_request_creator)
    # TODO: have this stub inside the factory itself
    pull_request.stub(comments: [])
    pull_request.save!

    badge_giver = create(:user)
    badge = Badge.new(body: ':100:', user: badge_giver, pull_request: pull_request)
    badge.save!

    score = Score.where(user: pull_request_creator).all_time.first
    expect(score.points).to eq(badge.points)
  end

  context 'when the pull request is more than one week old' do
    it "doesn't give points to the user for the weekly score" do
      pull_request_creator = create(:user)
      pull_request = build(:pull_request, merged_at: 1.month.ago, user: pull_request_creator)

      pull_request.stub(comments: [])
      pull_request.save!

      badge_giver = create(:user)
      badge = Badge.new(body: ':100:', user: badge_giver, pull_request: pull_request)
      badge.save!

      expect(Score.where(user: pull_request_creator).weekly.first).not_to be_present
    end
  end
end