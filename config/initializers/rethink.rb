if ENV['RETHINKDB_HOST']
  ENV['RETHINKDB_URL'] = "rethinkdb://#{ENV['RETHINKDB_HOST']}:#{ENV['RETHINKDB_PORT']}/#{Rails.application.class.parent_name.underscore}"
end