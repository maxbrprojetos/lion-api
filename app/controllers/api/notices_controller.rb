class Api::NoticesController < ApplicationController
  before_action :authenticate!

  def index
    @notices = Notice.all

    render json: @notices
  end

  def create
    @notice = Notice.new(notice_params)

    if @notice.save
      render json: @notice, status: :created
    else
      render json: { errors: @notice.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @notice = Notice.find(params[:id])

    @notice.destroy

    head :no_content
  end

  private

  def notice_params
    params.require(:notice).permit(:title, :client_id, :type, :app)
  end
end