class PagesController < ApplicationController

  def archives
    @posts = Post.order(publish_date: :desc)
  end

end
