class PostsController < ApplicationController

  def index
    @posts = Post.order(publish_date: :desc).page(params[:page].to_i)
    @nav = OpenStruct.new(
      {
        previous: (blog_page_url(@posts.prev_page) unless @posts.first_page?),
        next: (blog_page_url(@posts.next_page) unless @posts.last_page?),
        current: @posts.current_page,
        pages: (1..@posts.total_pages).map {|x| blog_page_url(x) }
      })
  end

  def show
    @post = Post.find_by_permalink(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:id)
  end
end
