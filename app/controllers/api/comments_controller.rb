module Api
  class CommentsController < ApplicationController
    before_action :authenticate!

    def create
      @comment = current_user.comments.build(comment_params)

      if @comment.save
        notify_comment_creation
        render json: @comment, status: :created
      else
        render json: { errors: @comment.errors }, status: :unprocessable_entity
      end
    end

    def update
      @comment = Comment.find(params[:id])

      if @comment.update(body: params[:comment][:body])
        render json: @comment, status: :ok
      else
        render json: { errors: @comment.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy

      head :no_content
    end

    private

    def comment_params
      params.require(:comment).permit(:body, :client_id, :task_id)
    end

    def notify_comment_creation
      flow.push_to_team_inbox(
        subject: 'Added Comment',
        content: @comment.body,
        tags: %w(comment),
        link: "https://as-lion.herokuapp.com/tasks/#{@comment.task.to_param}"
      )
    end
  end
end
