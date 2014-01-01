ENV['PUSHER_KEY'] = ENV['PUSHER_URL'].match(/https?:\/\/(.*):.*/)[1] if ENV['PUSHER_URL']

if ENV['PUSHER_APP_ID'] && ENV['PUSHER_KEY'] && ENV['PUSHER_SECRET']
  Pusher.app_id = ENV['PUSHER_APP_ID']
  Pusher.key = ENV['PUSHER_KEY']
  Pusher.secret = ENV['PUSHER_SECRET']
end