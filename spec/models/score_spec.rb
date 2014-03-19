require 'spec_helper'

describe Score do
  let(:user) { create(:user) }

  describe '#self.give' do
    it 'creates a Score with the specified points' do
      Score.give(time: Time.now, user: user, points: 10)

      score = Score.first
      score.points.should eq(10)
      score.user.should eq(user)
    end

    it 'increments the points of the existing Score' do
      Score.create(time: Time.now, user: user, points: 10)
      Score.give(time: Time.now, user: user, points: 5)

      Score.all_time.count.should eq(1)
      Score.all_time.first.points.should eq(15)
    end

    it 'creates a Score with the all_time time span' do
      Score.give(time: Time.now, user: user, points: 5)

      Score.all_time.first.should be_present
    end

    context 'when the scoring time is within the current week' do
      it 'creates a Score with the weekly time span' do
        Score.give(time: Time.now, user: user, points: 5)

        Score.weekly.first.should be_present
      end
    end

    context 'when the scorign time is not within the current week' do
      it "doesn't create a Score with the weekly time span" do
        Score.give(time: 1.month.ago, user: user, points: 5)

        Score.weekly.first.should_not be_present
      end
    end

  end

  describe '#self.take' do
    it 'decrements the Score points' do
      Score.give(time: Time.now, user: user, points: 5)
      Score.take(user: user, points: 5)

      Score.first.points.should eq(0)
    end
  end

  describe '#self.reset' do
    it 'resets scores points' do
      score = Score.create(user: user, points: 10)

      Score.reset

      score.reload.points.should eq(0)
    end
  end
end
