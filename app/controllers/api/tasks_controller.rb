module Api
  class TasksController < ApplicationController
    before_action :authenticate!

    def index
      @tasks = Task.where(completed: false).includes(:user)

      render json: @tasks
    end

    def create
      @task = current_user.tasks.build(task_params)

      if @task.save
        notify_task_creation
        render json: @task, status: :created
      else
        render json: { errors: @task.errors }, status: :unprocessable_entity
      end
    end

    def update
      @task = Task.find(params[:id])

      if @task.update(task_params)
        render json: @task, status: :ok
      else
        render json: { errors: @task.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      @task = Task.find(params[:id])

      @task.destroy
      notify_task_destruction

      head :no_content
    end

    private

    def task_params
      params.require(:task).permit(:title, :client_id, :assignee_id)
    end

    def notify_task_creation
      flow.push_to_team_inbox(
        subject: 'Added Task',
        content: @task.title,
        tags: %w(task),
        link: 'https://lion.herokuapp.com/#/tasks'
      )
    end

    def notify_task_destruction
      flow.push_to_team_inbox(
        subject: 'Deleted Task',
        content: @task.title,
        tags: %w(task),
        link: 'https://lion.herokuapp.com/#/tasks'
      )
    end
  end
end
