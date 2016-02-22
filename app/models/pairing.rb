class Pairing < ActiveRecord::Base
  belongs_to :user
  belongs_to :pull_request

  validates :pull_request, presence: true
  validates :user, presence: true
end
