class User < ActiveRecord::Base
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
      user = User.create(user_info)
    end

    user
  end
end
