$primary_user_client = User.find_by(nickname: ENV['PRIMARY_USER_NICKNAME']).github_client
$primary_user_client.auto_paginate = true
