require 'spec_helper'

describe PullRequest do
  describe "#points" do
    let(:pull_request) { described_class.new }

    context "more than 1000 deletions and more than double the additions" do
      it "returns 100" do
        allow(pull_request).to receive(:number_of_deletions).and_return(1001)
        allow(pull_request).to receive(:number_of_additions).and_return(50)
        expect(pull_request.points).to eq 100
      end
    end

    context "more than 500 additions" do
      it "returns 50" do
        allow(pull_request).to receive(:number_of_additions).and_return(501)
        allow(pull_request).to receive(:number_of_deletions).and_return(75)
        expect(pull_request.points).to eq 50
      end
    end

    context "more than 100 deletions and more than double the additions" do
      it "returns 30" do
        allow(pull_request).to receive(:number_of_deletions).and_return(101)
        allow(pull_request).to receive(:number_of_additions).and_return(50)
        expect(pull_request.points).to eq 30
      end
    end

    context "more than 100 additions" do
      it "returns 15" do
        allow(pull_request).to receive(:number_of_additions).and_return(101)
        allow(pull_request).to receive(:number_of_deletions).and_return(50)
        expect(pull_request.points).to eq 15
      end
    end

    context "less than 10 additions" do
      it "returns 5" do
        allow(pull_request).to receive(:number_of_additions).and_return(1)
        allow(pull_request).to receive(:number_of_deletions).and_return(50)
        expect(pull_request.points).to eq 5
      end
    end

    context "less than 100 deletions and additions between 10 and 100" do
      it "returns 10" do
        allow(pull_request).to receive(:number_of_additions).and_return(75)
        allow(pull_request).to receive(:number_of_deletions).and_return(50)
        expect(pull_request.points).to eq 10
      end
    end
  end
end
