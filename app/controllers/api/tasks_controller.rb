class Api::TasksController < ApplicationController
  before_action :authenticate!

  def index
    @tasks = Task.where(completed: false).includes(:user)

    render json: @tasks
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      $flow.push_to_team_inbox(
        subject: 'New Task',
        content: @task.title,
        tags: ['notdvs', 'task'],
        link: 'https://notdvs.herokuapp.com/#/tasks'
      )

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

    head :no_content
  end


  private

  def task_params
    params.require(:task).permit(:title, :client_id, :assignee_id)
  end
end