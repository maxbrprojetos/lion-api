module Api
  class PullRequestsController < ApplicationController
    def create
      if action == 'closed'
        begin
          PointsMarshaler.new(data: pull_request_params).marshal
        rescue ActiveRecord::RecordNotUnique => e
          Honeybadger.notify(e, context: pull_request_params)
        end
      end

      head :ok
    end

    private

    def pull_request_params
      data = if params['payload']
        params['payload']['pull_request']
      else
        params['pull_request']
      end

      {
        user: User.where(nickname: data['user']['login']).first,
        base_repo_full_name: data['base']['repo']['full_name'],
        body: data['body'],
        number: data['number'],
        number_of_comments: data['comments'],
        number_of_commits: data['commits'],
        number_of_additions: data['additions'],
        number_of_deletions: data['deletions'],
        number_of_changed_files: data['changed_files'],
        merged_at: merged_at(data['merged_at'])
      }
    end

    def merged_at(value)
      Time.parse(value) if value.present?
    end

    def action
      # the magic params[:action] masks the github param
      if params['payload']
        params['payload']['action']
      else
        JSON.parse(request.body.read)['action']
      end
    end
  end
end
