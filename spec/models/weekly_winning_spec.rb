require 'spec_helper'

describe WeeklyWinning do
  it 'has to be one per week' do
    create(:weekly_winning, start_date: Time.now)
    expect(build(:weekly_winning, start_date: Time.now)).to be_invalid
  end
end
