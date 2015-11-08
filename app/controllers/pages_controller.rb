class PagesController < ApplicationController
  def index
  end

  def archives
    @posts = Post.order(publish_date: :desc)
  end

end
