namespace :backfill do
  # Arguments:
  #   pr_id - Id of Pull Request to update
  task :update_pull_request_title, [:pr_id] => :environment do |t, args|
    if args.pr_id.nil?
      abort "Must include a Pull Request ID."
    end

    pull_request = PullRequest.find(args.pr_id)
    old_value = pull_request.title

    response = User.global_client.pull_request(pull_request.base_repo_full_name, pull_request.number)
    current_title = response.title

    if (old_value != current_title)
      puts "Updated #{pull_request.base_repo_full_name}##{pull_request.number} title from #{old_value.nil? ? 'nil': old_value} to #{current_title}."
    else
      puts "#{pull_request.base_repo_full_name}##{pull_request.number} title has not changed."
    end
  end
end
