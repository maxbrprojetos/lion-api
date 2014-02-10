class Api::NoticesController < ApplicationController
  before_action :authenticate!

  def index
    @notices = Notice.all

    render json: @notices
  end

  def create
    @notice = Notice.new(notice_params)

    if @notice.save
      notify_notice_creation
      render json: @notice, status: :created
    else
      render json: { errors: @notice.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @notice = Notice.find(params[:id])

    @notice.destroy
    notify_notice_destruction

    head :no_content
  end

  private

  def notice_params
    params.require(:notice).permit(:title, :client_id, :type, :app)
  end

  def notify_notice_creation
    flow.push_to_team_inbox(
      subject: "Added Notice for #{@notice.app.capitalize}",
      content: @notice.title,
      tags: %w(notice new),
      link: 'https://notdvs.herokuapp.com'
    )
  end

  def notify_notice_destruction
    flow.push_to_team_inbox(
      subject: "Deleted Notice for #{@notice.app.capitalize}",
      content: @notice.title,
      tags: %w(notice deleted),
      link: 'https://notdvs.herokuapp.com'
    )
  end
end
