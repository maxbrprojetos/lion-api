require 'spec_helper'

describe PullRequestReview do
  it 'has a valid factory' do
    expect(build(:pull_request_review)).to be_valid
  end

  describe '#approval?' do
    subject { described_class.new(state: state) }

    context 'when the state is APPROVED' do
      let(:state) { PullRequestReview::APPROVAL_STATE }

      it 'is true' do
        expect(subject.approval?).to eq true
      end
    end

    context 'when the state is not APPROVED' do
      let(:state) { 'COMMENTED' }

      it 'is false' do
        expect(subject.approval?).to eq false
      end
    end
  end
end
