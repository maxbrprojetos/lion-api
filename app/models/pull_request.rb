# == Schema Information
#
# Table name: pull_requests
#
#  id                  :uuid             not null, primary key
#  base_repo_full_name :string(255)
#  number              :integer
#  user_id             :uuid
#  created_at          :datetime
#  updated_at          :datetime
#

class PullRequest < ActiveRecord::Base
  belongs_to :user

  attr_accessor :pull_request_data

  validates :user, presence: true
  validates :number, presence: true, numericality: true
  validates :repo_full_name, presence: true
  validate :must_be_merged

  def pull_request_data=(pull_request)
    self.user = User.where(nickname: pull_request[:user][:login]).first
    self.base_repo_full_name = pull_request[:base][:repo][:full_name]
    super
  end

  private

  def must_be_merged
    errors.add(:base, 'PR must be merged') unless pull_request_data[:merged] == true
  end
end
