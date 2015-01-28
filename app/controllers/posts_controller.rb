class PostsController < ApplicationController

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show
    @post = Post.last
  end

  private
    def post_params
      params.require(:post).permit(:category, :title, :content)
    end
end
