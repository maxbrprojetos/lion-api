# == Schema Information
#
# Table name: users
#
#  id         :uuid             not null, primary key
#  name       :string(255)
#  nickname   :string(255)
#  email      :string(255)
#  avatar_url :string(255)
#  api_token  :string(255)
#  github_id  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  include Pushable

  has_many :tasks
  has_many :task_completions
  has_many :pull_requests
  has_many :scores
  has_many :comments
  has_many :pull_request_reviews
  has_many :weekly_winnings
  has_many :badges

  validates :name, presence: true
  validates :nickname, presence: true
  validates :email, presence: true
  validates :avatar_url, presence: true
  validates :api_token, presence: true
  validates :github_id, presence: true

  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(github_id: auth_hash['uid']).first
    info = user_info(auth_hash)

    if user
      user.update(info)
    else
      user = create_from_github(info)
    end

    user
  end

  # used only from the console
  def github_client
    @github_client ||= self.class.github_client(api_token)
  end

  def self.user_info(auth_hash)
    {
      name: auth_hash['info']['name'],
      github_id: auth_hash['uid'],
      nickname: auth_hash['info']['nickname'],
      email: auth_hash['info']['email'],
      avatar_url: auth_hash['info']['image'],
      api_token: auth_hash['credentials']['token']
    }
  end

  def self.github_client(api_token)
    client = Octokit::Client.new(access_token: api_token)
    client.user.login
    client
  end

  def self.create_from_github(info)
    if github_client(info[:api_token]).organizations.map(&:login).include?(ENV['ORGANIZATION_NAME'])
      create(info)
    else
      nil
    end
  end
end
