class Db < Thor
  include Thor::Actions

  no_tasks do
    def database
      env = ENV['RAILS_ENV'] || 'development'
      YAML.load_file('config/database.yml')[env]['database']
    end

    def run_sql(sql)
      say_status :sql, sql
      `echo "#{sql}" |  psql -d #{database}`
    end

    def cpu_cores
      Integer(`sysctl -n hw.ncpu`) rescue 3
    end
  end

  desc "capture", "capture production snapshot"
  def capture
    puts "Capturing production database..."
    run('heroku pg:backups capture --app as-lion-api-staging')
  end

  desc "pull", "pull production snapshot"
  def pull
    puts "Downloading production snapshot..."
    url = `heroku pg:backups public-url --app as-lion-api-staging`.gsub("\"", "").strip
    success = system(%{curl "#{url}" -# -o /tmp/latest.dump})
    unless success
      puts "Failed to download"
      exit -1
    end
  end

  desc "migrate", "migrate local database based on pulled snapshot"
  def migrate
    if !File.exist?("/tmp/latest.dump")
      say "DB Dump is not present. Ending task."
      return
    end
    run_sql("SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE pid <> pg_backend_pid();")
    run("dropdb #{database}")
    run("createdb #{database}")
    run("pg_restore --no-owner --jobs=#{cpu_cores} -d #{database} /tmp/latest.dump")
    run("rake db:migrate")
  end


  desc "sync", "download the latest production snapshot and migrate local database"
  def sync
    invoke :pull
    invoke :migrate
  end
end
