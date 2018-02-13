namespace :backfill do
  # Bulk updates all Pull Requests with no Titles via Github API
  task :update_pull_request_titles => :environment do |t, args|
    pull_requests_without_titles = PullRequest.where(:title => nil)
    update_count = pull_requests_without_titles.count

    pull_requests_without_titles.each do |pr|
      begin
        response = User.global_client.pull_request(pr.base_repo_full_name, pr.number)
        pr.update!(:title => response.title)
        puts '.'
      rescue Exception
        puts 'x'
      end
    end

    puts "Successfully updated #{update_count} Pull Requests."
  end
end
