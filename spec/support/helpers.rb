module Helpers
  def current_user
    User.where(
      api_token: 'api_token_test',
      nickname: 'current_user',
      avatar_url: 'omg',
      email: 'test@test.com',
      name: 'Test',
      github_id: '1'
    ).first_or_create
  end

  def matteo_auth_hash
    {
      'provider' => 'github',
      'uid' => '151725',
      'info' => {
        'nickname' => 'matteodepalo',
        'email' => 'matteodepalo@gmail.com',
        'name' => 'Matteo Depalo',
        'image' => 'https://gravatar.com/avatar/abb04b4653729868f052994150255f97?d=https%3A%2F%2Fidenticons',
        'urls' => {
          'GitHub' => 'https://github.com/matteodepalo',
          'Blog' => 'http://matteodepalo.github.io/'
        }
      },
      'credentials' => {
        'token' => '78f58e63e8035da8e50970736e71f592c8b3513f',
        'expires' => false
      },
      'extra' => {
        'raw_info' => {
          'login' => 'matteodepalo',
          'id' => 151_725,
          'avatar_url' => 'https://gravatar.com/avatar/abb04b4653729868f052994150255f97?d=https%3A%2F',
          'gravatar_id' => 'abb04b4653729868f052994150255f97',
          'url' => 'https://api.github.com/users/matteodepalo',
          'html_url' => 'https://github.com/matteodepalo',
          'followers_url' => 'https://api.github.com/users/matteodepalo/followers',
          'following_url' => 'https://api.github.com/users/matteodepalo/following{/other_user}',
          'gists_url' => 'https://api.github.com/users/matteodepalo/gists{/gist_id}',
          'starred_url' => 'https://api.github.com/users/matteodepalo/starred{/owner}{/repo}',
          'subscriptions_url' => 'https://api.github.com/users/matteodepalo/subscriptions',
          'organizations_url' => 'https://api.github.com/users/matteodepalo/orgs',
          'repos_url' => 'https://api.github.com/users/matteodepalo/repos',
          'events_url' => 'https://api.github.com/users/matteodepalo/events{/privacy}',
          'received_events_url' => 'https://api.github.com/users/matteodepalo/received_events',
          'type' => 'User',
          'site_admin' => false,
          'name' => 'Matteo Depalo',
          'company' => '',
          'blog' => 'http://matteodepalo.github.io/',
          'location' => 'Siena, Italy',
          'email' => 'matteodepalo@gmail.com',
          'hireable' => true,
          'bio' => '',
          'public_repos' => 23,
          'public_gists' => 15,
          'followers' => 11,
          'following' => 5,
          'created_at' => '2009-11-11T10:12:38Z',
          'updated_at' => '2014-01-14T19:35:13Z'
        }
      }
    }
  end
end
