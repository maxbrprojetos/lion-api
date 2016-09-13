require 'spec_helper'

describe PointsMarshaler do
  describe "matching regex" do
    subject { PointsMarshaler::MATCHING_REGEX }

    context "when the marker phrase is capitalized" do
      let(:body) { "My name is @edjohn. I Paired with @delkopiso" }
      it "matches the listed users" do
        expect(body.match(subject)[:names]).to eq "@delkopiso"
      end
    end

    context "when the marker phrase is non-space delimited" do
      let(:body) { "My name is @edjohn. I pairedwith @delkopiso" }
      it "matches the listed users" do
        expect(body.match(subject)[:names]).to eq "@delkopiso"
      end
    end

    context "when the marker phrase is capitalized and non-space delimited" do
      let(:body) { "My name is @edjohn. I Pairedwith @delkopiso" }
      it "matches the listed users" do
        expect(body.match(subject)[:names]).to eq "@delkopiso"
      end
    end

    context "when 1 user is listed" do
      let(:body) { "My name is @edjohn. I paired with @delkopiso" }
      it "matches the listed users" do
        expect(body.match(subject)[:names]).to eq "@delkopiso"
      end
    end

    context "when 1 user is listed termniating in a period" do
      let(:body) { "My name is @edjohn. I paired with @delkopiso." }
      it "matches the listed users" do
        expect(body.match(subject)[:names]).to eq "@delkopiso"
      end
    end

    context "when 2 users are listed separated by 'and'" do
      let(:body) { "My name is @edjohn. I paired with @delkopiso and @abe" }
      it "matches the listed users" do
        expect(body.match(subject)[:names]).to eq "@delkopiso and @abe"
      end
    end

    context "when 2 users are listed separated by 'and', period termniated" do
      let(:body) { "My name is @edjohn. I paired with @delkopiso and @abe." }
      it "matches the listed users" do
        expect(body.match(subject)[:names]).to eq "@delkopiso and @abe"
      end
    end

    context "when 3 users are listed separated by ',' and 'and'" do
      let(:body) { "My name is @edjohn. I paired with @delkopiso, @jake and @abe" }
      it "matches the listed users" do
        expect(body.match(subject)[:names]).to eq "@delkopiso, @jake and @abe"
      end
    end

    context "when 3 users are listed separated by ',' and 'and', period termniated" do
      let(:body) { "My name is @edjohn. I paired with @delkopiso, @jake and @abe." }
      it "matches the listed users" do
        expect(body.match(subject)[:names]).to eq "@delkopiso, @jake and @abe"
      end
    end

    context "when 3 users are listed separated by ',' with no space and 'and'" do
      let(:body) { "My name is @edjohn. I paired with @delkopiso,@jake and @abe" }
      it "matches the listed users" do
        expect(body.match(subject)[:names]).to eq "@delkopiso,@jake and @abe"
      end
    end

    context "when 3 users are listed separated by ',' with no space and 'and' period terminated" do
      let(:body) { "My name is @edjohn. I paired with @delkopiso,@jake and @abe." }
      it "matches the listed users" do
        expect(body.match(subject)[:names]).to eq "@delkopiso,@jake and @abe"
      end
    end
  end

  describe "splitting regex" do
    subject { PointsMarshaler::SPLITTING_REGEX }

    context "when 1 user is listed" do
      let(:text) { "@delkopiso" }
      it "splits the words properly" do
        expect(text.split(subject)).to match_array ["@delkopiso"]
      end
    end

    context "when 2 users are listed separated by 'and'" do
      let(:text) { "@delkopiso and @abe" }
      it "splits the words properly" do
        expect(text.split(subject)).to match_array ["@delkopiso", "and", "@abe"]
      end
    end

    context "when 3 users are listed separated by ',' with space and 'and'" do
      let(:text) { "@delkopiso, @jake and @abe" }
      it "splits the words properly" do
        expect(text.split(subject)).to match_array ["", "@delkopiso", "@jake", "and", "@abe"]
      end
    end

    context "when 3 users are listed separated by ',' with no space and 'and'" do
      let(:text) { "@delkopiso,@jake and @abe" }
      it "splits the words properly" do
        expect(text.split(subject)).to match_array ["@delkopiso", "@jake", "and", "@abe"]
      end
    end
  end

  describe "#marshal" do
    let(:user) { create(:user) }
    let(:paired_user) { create(:user) }
    let(:reviewer) { create(:user) }
    let(:params) do
      {
        user: user,
        base_repo_full_name: "#{Faker::Internet.user_name}/#{Faker::Lorem.word}",
        body: Faker::Lorem.sentence,
        number: Faker::Number.number(3).to_i,
        merged_at: "#{Time.new(2016, 1, 2)}",
        number_of_comments: Faker::Number.number(2).to_i,
        number_of_commits: Faker::Number.number(2).to_i,
        number_of_additions: Faker::Number.number(2).to_i,
        number_of_deletions: Faker::Number.number(2).to_i,
        number_of_changed_files: Faker::Number.number(2).to_i
      }
    end

    it "creates a pull request" do
      allow_any_instance_of(PullRequest).to receive(:comments).and_return([])
      pull_request = described_class.new(data: params).marshal

      expect(pull_request.persisted?).to eq true
    end

    it "creates a pull request review and scores it" do
      allow_any_instance_of(PullRequest).to receive(:comments)
        .and_return([
          double(user: double(login: reviewer.nickname), body: "LGTM :+1:")
          ])
      pull_request = described_class.new(data: params).marshal

      pull_request_reviewers = pull_request.pull_request_reviews.pluck(:user_id)
      expect(pull_request_reviewers.count).to eq 1

      review_points = Score.where(user: pull_request_reviewers)
        .all_time.pluck(:points)
      expect(review_points.all?{ |p| p == pull_request.points / 2 }).to eq true
    end

    it "creates and scores pairings" do
      expect(Score.count).to eq 0
      allow_any_instance_of(PullRequest).to receive(:comments).and_return([])
      params[:body] += "I paired with @#{paired_user.nickname}"
      pull_request = described_class.new(data: params).marshal

      pairers = Pairing.where(pull_request_id: pull_request.id)
      expect(pairers.count).to eq 2

      pair_points = Score.where(user_id: pairers.map(&:user_id))
      expect(pair_points.sum(:points)).to eq pull_request.points
      pair_points.each do |p|
        expect(p.points).to eq pull_request.points / 2
      end
    end
  end
end
