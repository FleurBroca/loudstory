class CommentsController < ApplicationController

  before_action :set_answer, only: [:index, :create, :new, :destroy]

  def index
    @comments = @answer.comments.all
  end

  def new
    @comment = @answer.comments.new
  end

  def create
    @comment = @answer.comments.new(comment_params)

    if @comment.save
      redirect_to exercise_session_path(@answer.exercise, @answer.session)
    else
      render :new
    end
  end

  def destroy
    @comment = @answer.comments.find(params[:id])
    @comment.destroy
    redirect_to exercise_session_path(@answer.exercise, @answer.session)
  end

  private

  def set_answer
    @answer = Answer.find(params[:answer_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :answer_id, :user_id)
  end

end