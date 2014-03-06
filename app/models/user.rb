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
#  points     :integer          default(0)
#

class User < ActiveRecord::Base
  include Pusherable

  has_many :tasks
  has_many :task_completions

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

  def increment_points_by(points_to_add)
    transaction do
      update(points: points + points_to_add)
    end
  end

  def decrement_points_by(points_to_remove)
    transaction do
      update(points: points - points_to_remove)
    end
  end

  private

  def self.serializer
    UserSerializer
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

  def self.create_from_github(info)
    client = Octokit::Client.new(access_token: info[:api_token])
    user = client.user
    user.login

    if client.organizations.map(&:login).include?('alphasights')
      User.create(info)
    else
      nil
    end
  end
end
