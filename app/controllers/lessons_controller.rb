class LessonsController < ApplicationController
  before_action :set_lesson
  before_action :load_post

  def show

  end

  def move_up
    @lesson.move_higher
    authorize @lesson
    redirect_to post_lessons_url
  end

  def move_down
    @lesson.move_lower
    authorize @lesson
    redirect_to post_lessons_url
  end

  private
  def set_lesson
  @lesson = Lesson.find(params[:id])
  end

  def load_post
  @post = Post.find(params[:post_id])
  end

end
