require 'spec_helper'

describe Pairing do
  describe '#points' do
    it 'returns a fraction of pr points' do
      user = build(:user)
      paired_user = create(:user)
      pull_request = build(:pull_request, user: user)
      pull_request.body = "## I paired with @#{paired_user.nickname} on this."
      allow(pull_request).to receive(:comments).and_return([])
      # pull_request.number_of_additions = 1001
      # pull_request.number_of_deletions = 3000
      pull_request.save!

      pairing = Pairing.where(user: paired_user).first
      expect(pairing.points).to eq(pull_request.points / 2)
    end
  end

  it 'gives points to the paired user' do
    user = build(:user)
    paired_user = create(:user)
    pull_request = build(:pull_request, user: user)
    pull_request.body = "## I paired with @#{paired_user.nickname} on this."
    allow(pull_request).to receive(:comments).and_return([])
    pull_request.save!
    binding.pry

    pairing = Pairing.where(user: paired_user).first
    score = Score.where(user: paired_user).all_time.first
    expect(score.points).to eq(pairing.points)
  end

  context 'when the pull request is more than one week old' do
    it "doesn't give points to the user for the weekly score" do
      paired_user = create(:user)
      pull_request = build(:pull_request, merged_at: 1.month.ago)
      pull_request.body = "## I paired with @#{paired_user.nickname} on this."
      allow(pull_request).to receive(:comments).and_return([])
      pull_request.save!

      # pairing = Pairing.where(user: paired_user).first
      expect(Score.where(user: paired_user).weekly.first).not_to be_present
    end
  end
end
