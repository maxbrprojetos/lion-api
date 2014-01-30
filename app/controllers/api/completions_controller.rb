class Api::CompletionsController < ApplicationController
  before_action :authenticate!

  def create
    @completion = Completion.new(
      completable_id: params[:completable][:id], completable_type: params[:completable][:type]
    )
    @completion.save

    render json: @completion.completable, status: :created
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