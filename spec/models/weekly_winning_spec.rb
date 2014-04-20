# == Schema Information
#
# Table name: weekly_winnings
#
#  id         :uuid             not null, primary key
#  winner_id  :uuid
#  start_date :date
#  points     :integer          default(0)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe WeeklyWinning do
  it 'has to be one per week' do
    create(:weekly_winning, start_date: Time.now)
    expect(build(:weekly_winning, start_date: Time.now)).to be_invalid
  end
end
