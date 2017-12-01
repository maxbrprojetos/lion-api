require 'spec_helper'

describe Score do
  let(:user) { create(:user) }

  describe '.give' do
    it 'creates a Score with the specified points' do
      Score.give(time: Time.now, user: user, points: 10)

      score = Score.first
      expect(score.points).to eq(10)
      expect(score.user).to eq(user)
    end

    it 'increments the points of the existing Score' do
      Score.create(time: Time.now, user: user, points: 10)
      Score.give(time: Time.now, user: user, points: 5)

      expect(Score.all_time.count).to eq(1)
      expect(Score.all_time.first.points).to eq(15)
    end

    it 'creates a Score with the all_time time span' do
      Score.give(time: Time.now, user: user, points: 5)

      expect(Score.all_time.first).to be_present
    end

    context 'when the scoring time is within the current week' do
      it 'creates a Score with the weekly time span' do
        Score.give(time: Time.now, user: user, points: 5)

        expect(Score.weekly.first).to be_present
      end
    end

    context 'when the scorign time is not within the current week' do
      it "doesn't create a Score with the weekly time span" do
        Score.give(time: 1.month.ago, user: user, points: 5)

        expect(Score.weekly.first).not_to be_present
      end
    end
  end

  describe '.top_weekly' do
    it 'returns the top weekly score' do
      Score.create(user: user, points: 50, time_span: 'all_time')
      Score.create(user: user, points: 10, time_span: 'weekly')
      top_score = Score.create(user: user, points: 20, time_span: 'weekly')

      expect(Score.top_weekly).to eq(top_score)
    end
  end
end
