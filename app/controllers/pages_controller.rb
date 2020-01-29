class PagesController < ApplicationController


  def archives
    @posts = Post.where(['publish_date <= ?', DateTime.now]).order(publish_date: :desc)
  end

  def home
    expires_in 30.days, public: true, must_revalidate: true
  end

  def feed
    @posts = Post.where(['publish_date <= ?', DateTime.now]).order(publish_date: :desc).limit(20)

    respond_to do |format|
      format.rss  { render layout: false }
      format.atom { render layout: false }
    end

  end

end
