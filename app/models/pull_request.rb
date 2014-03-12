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
  include Scorable

  belongs_to :user

  attr_accessor :data, :merged

  validates :user, presence: true
  validates :number, presence: true, numericality: true
  validates :base_repo_full_name, presence: true
  validate :must_be_merged

  def data=(data)
    self.user ||= User.where(nickname: data['user']['login']).first
    self.base_repo_full_name ||= data['base']['repo']['full_name']
    self.number ||= data['number']
    self.merged ||= data['merged'].to_s
    self.number_of_comments ||= data['comments']
    self.number_of_commits ||= data['commits']
    self.number_of_additions ||= data['additions']
    self.number_of_deletions ||= data['deletions']
    self.number_of_changed_files ||= data['changed_filles']

    @data = data
  end

  def points
    return 10 unless number_of_deletions && number_of_additions

    if number_of_deletions > 2 * number_of_additions && number_of_deletions > 20
      30
    elsif number_of_additions > 100
      15
    elsif number_of_additions < 10
      5
    else
      10
    end
  end

  private

  def must_be_merged
    errors.add(:base, 'PR must be merged') unless merged == 'true'
  end
end
