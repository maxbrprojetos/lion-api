class Api::CompletionsController < ApplicationController
  before_action :authenticate!

  def create
    @completion = Completion.new(
      completable_id: params[:completable][:id], completable_type: params[:completable][:type]
    )

    if @completion.save
      notify_completion_creation
      render json: @completion.completable, status: :created
    else
      render json: @completion.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @completion = Completion.where(
      completable_id: params[:completable][:id], completable_type: params[:completable][:type]
    ).first

    head :not_found and return unless @completion

    @completion.destroy
    render json: @completion.completable, status: :ok
  end

  private

  def notify_completion_creation
    Notdvs.flow.push_to_team_inbox(
      subject: "Completed #{@completion.completable.class.name}",
      content: @completion.completable.title,
      tags: %w(task completed),
      link: 'https://notdvs.herokuapp.com/#/tasks'
    )
  end
end
