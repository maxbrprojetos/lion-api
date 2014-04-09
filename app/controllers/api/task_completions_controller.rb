module Api
  class TaskCompletionsController < ApplicationController
    before_action :authenticate!

    def create
      @task_completion = TaskCompletion.new(task_completion_params)

      if @task_completion.save
        notify_task_completion_creation
        render json: @task_completion, status: :created
      else
        render json: @task_completion.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @task_completion = TaskCompletion.where(task_id: params[:task_id]).first

      head :not_found and return unless @task_completion

      @task_completion.destroy
      render json: @task_completion, status: :ok
    end

    private

    def task_completion_params
      params.require(:task_completion).permit(:user_id, :task_id)
    end

    def notify_task_completion_creation
      flow.push_to_team_inbox(
        subject: 'Completed Task',
        content: @task_completion.task.title,
        tags: %w(task),
        link: 'https://lion.herokuapp.com/#/tasks'
      )
    end
  end
end
