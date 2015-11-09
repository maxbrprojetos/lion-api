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
  has_many :access_tokens, dependent: :destroy

  validates :name, presence: true
  validates :nickname, presence: true
  validates :email, presence: true
  validates :avatar_url, presence: true
  validates :github_id, presence: true

  class_attribute :current_client_index

  def access_token
    access_tokens.active.first
  end

  def self.find_or_create_from_oauth(oauth, access_token)
    user = where(github_id: oauth.id.to_s).first
    info = user_info(oauth)

    if user
      user.update(info)
    else
      user = create_from_github(info, access_token)
    end

    user
  end

  def self.user_info(oauth)
    {
      name: oauth.name,
      github_id: oauth.id.to_s,
      nickname: oauth.login,
      email: oauth.email,
      avatar_url: oauth.avatar_url
    }
  end

  def self.github_client(access_token)
    client = Octokit::Client.new(access_token: access_token)
    client.user.login
    client
  end

  def self.create_from_github(info, access_token)
    if github_client(access_token).organizations.map(&:login).include?(ENV['ORGANIZATION_NAME'])
      create(info)
    else
      nil
    end
  end

  def self.global_client
    self.current_client_index ||= 1
    client = clients[current_client_index]

    if client.rate_limit[:remaining] < 100
      self.current_client_index += 1
      client = clients[current_client_index]
    else
      client
    end
  end

  def self.clients
    @clients ||= User.where(nickname: ENV['USERS'].split(',')).map(&:github_client)
  end
end
