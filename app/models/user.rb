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
  has_many :tasks

  def self.find_or_create_from_auth_hash(auth_hash)
    user = self.where(github_id: auth_hash['uid']).first

    user_info = {
      name: auth_hash['info']['name'],
      github_id: auth_hash['uid'],
      nickname: auth_hash['info']['nickname'],
      email: auth_hash['info']['email'],
      avatar_url: auth_hash['info']['image'],
      api_token: auth_hash['credentials']['token']
    }

    if user
      user.update(user_info)
    else
      client = Octokit::Client.new(access_token: user_info[:api_token])
      user = client.user
      user.login

      if client.organizations.map(&:login).include?('alphasights')
        user = User.create(user_info)
      else
        user = nil
      end
    end

    user
  end
end
