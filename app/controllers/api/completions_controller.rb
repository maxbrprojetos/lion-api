class Api::CompletionsController < ApplicationController
  before_action :authenticate!

  def create
    @completion = Completion.new(
      completable_id: params[:completable][:id], completable_type: params[:completable][:type]
    )

    if @completion.save
      $flow.push_to_team_inbox(
        subject: "#{@completion.completable.class.name} Completed",
        content: @completion.completable.title,
        tags: ['notdvs', 'task'],
        link: 'https://notdvs.herokuapp.com/#/tasks'
      )

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
end