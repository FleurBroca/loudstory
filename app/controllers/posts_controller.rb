class PostsController < ApplicationController

  def index
    @posts = Post.all.order('position ASC')
  end

  private
    def post_params
      params.require(:post).permit(:category, :title, :content)
    end
end
