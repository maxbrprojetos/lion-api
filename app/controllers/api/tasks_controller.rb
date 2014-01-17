class Api::TasksController < ApplicationController
  def index
    @tasks = Task.all

    render json: @tasks
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors }, status: :unprocessable_entity
    end
  end

  def update
    @task = Task.find(params[:id])

    @task.destroy

    head :no_content
  end

  private

  def task_params
    params.require(:task).permit(:title, :client_id, :type, :app)
  end
end