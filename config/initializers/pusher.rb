if ENV['PUSHER_APP_ID']
  Pusher.app_id = ENV['PUSHER_APP_ID']
  Pusher.key = ENV['PUSHER_KEY']
  Pusher.secret = ENV['PUSHER_SECRET']
elsif ENV['PUSHER_URL']
  ENV['PUSHER_KEY'] = ENV['PUSHER_URL'].match(/https?:\/\/(.*):.*/)[1]
end

Pusher.encrypted = true