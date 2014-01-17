class Api::TasksController < ApplicationController
  def index
    @tasks = Task.all

    render json: @tasks
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
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
    params.require(:task).permit(:title, :completed, :client_id)
  end
end