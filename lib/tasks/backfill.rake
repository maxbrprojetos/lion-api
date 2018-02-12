namespace :backfill do
  # Arguments:
  #   pr_id - Id of Pull Request to update
  #   attr_name - Name of attribute on Pull Request model to update
  #   (optional) key_map - Name of JSON key associated with attribute
  task :update_pull_request_attribute, [:pr_id, :attr_name, :key_map] => :environment do |t, args|
    if args.to_a.length < 2
      abort "Must include at least the Pull Request ID and Attribute to be updated."
    end

    pull_request_id = args.pr_id
    attr_name = args.attr_name
    key_map = args.key_map || args.attr_name

    pull_request = PullRequest.find(pull_request_id)
    old_value = pull_request.read_attribute(attr_name)

    response = User.global_client.pull_request(pull_request.base_repo_full_name, pull_request.number)

    begin
      current_value = response.fetch(key_map)
    rescue KeyError => e
      abort "#{key_map} is not a valid key for the pull request JSON response."
    end

    if (old_value != current_value)
      puts "Updated #{pull_request.base_repo_full_name}##{pull_request.number} #{attr_name} from #{old_value.nil? ? 'nil': old_value} to #{current_value}."
    else
      puts "#{pull_request.base_repo_full_name}##{pull_request.number} #{attr_name} has not changed."
    end
  end
end
