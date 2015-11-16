class SitemapsController < ApplicationController

  def posts
    @posts = Post.all
    respond_to do |format|
      format.xml
    end
  end

  def images
    @images = Image.all
    respond_to do |format|
      format.xml
    end
  end

end
