class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    comment = Comment.new(comment_params)
    comment.save
    redirect_to exercise_session_path(exercise, session)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to exercise_session_path(exercise, session)

  end

  private
    def comment_params
      params.require(:comment).permit(:content, :answer_id)
    end

end