$flow = Flowdock::Flow.new(
  api_token: ENV['FLOWDOCK_API_TOKEN'],
  source: 'NOTDVS',
  from: { name: 'NOTDVS', address: 'noreply@notdvs-herokuapp.com' }
)