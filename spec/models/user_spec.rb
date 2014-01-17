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

require 'spec_helper'

describe User do
  describe '#self.find_or_create_from_auth_hash' do
    let(:auth_hash) do
      {
        "provider" => "github",
        "uid" => "151725",
        "info" => {
          "nickname" => "matteodepalo",
          "email" => "matteodepalo@gmail.com",
          "name" => "Matteo Depalo",
          "image" => "https://gravatar.com/avatar/abb04b4653729868f052994150255f97?d=https%3A%2F%2Fidenticons",
          "urls" => {
            "GitHub" => "https://github.com/matteodepalo",
            "Blog" => "http://matteodepalo.github.io/"
          }
        },
        "credentials" => {
          "token" => "78f58e63e8035da8e50970736e71f592c8b3513f",
          "expires" => false
        },
        "extra" => {
          "raw_info" => {
            "login" => "matteodepalo",
            "id" => 151725,
            "avatar_url" => "https://gravatar.com/avatar/abb04b4653729868f052994150255f97?d=https%3A%2F",
            "gravatar_id" => "abb04b4653729868f052994150255f97",
            "url" => "https://api.github.com/users/matteodepalo",
            "html_url" => "https://github.com/matteodepalo",
            "followers_url" => "https://api.github.com/users/matteodepalo/followers",
            "following_url" => "https://api.github.com/users/matteodepalo/following{/other_user}",
            "gists_url" => "https://api.github.com/users/matteodepalo/gists{/gist_id}",
            "starred_url" => "https://api.github.com/users/matteodepalo/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/matteodepalo/subscriptions",
            "organizations_url" => "https://api.github.com/users/matteodepalo/orgs",
            "repos_url" => "https://api.github.com/users/matteodepalo/repos",
            "events_url" => "https://api.github.com/users/matteodepalo/events{/privacy}",
            "received_events_url" => "https://api.github.com/users/matteodepalo/received_events",
            "type" => "User",
            "site_admin" => false,
            "name" => "Matteo Depalo",
            "company" => "",
            "blog" => "http://matteodepalo.github.io/",
            "location" => "Siena, Italy",
            "email" => "matteodepalo@gmail.com",
            "hireable" => true,
            "bio" => "",
            "public_repos" => 23,
            "public_gists" => 15,
            "followers" => 11,
            "following" => 5,
            "created_at" => "2009-11-11T10:12:38Z",
            "updated_at" => "2014-01-14T19:35:13Z"
          }
        }
      }
    end

    it 'creates a new user from github credentials' do
      user = User.find_or_create_from_auth_hash(auth_hash)

      user.name.should eq('Matteo Depalo')
      user.email.should eq('matteodepalo@gmail.com')
      user.api_token.should eq('78f58e63e8035da8e50970736e71f592c8b3513f')
      user.avatar_url.should eq('https://gravatar.com/avatar/abb04b4653729868f052994150255f97?d=https%3A%2F%2Fidenticons')
      user.github_id.should eq('151725')
      user.nickname.should eq('matteodepalo')
    end

    it 'updates infos about a github user already in the database' do
      user = User.find_or_create_from_auth_hash(auth_hash)
      user.name.should eq('Matteo Depalo')
      id = user.id

      user = User.find_or_create_from_auth_hash(auth_hash.deep_merge!('info' => { 'name' => 'Ciccio Depalo' }))
      user.name.should eq('Ciccio Depalo')
      user.id.should eq(id)
    end
  end
end
