class TermsController < ApplicationController
  def category
    @posts = load_posts(params[:term_slug], 'category')
    render 'posts/index'
  end

  def tag
    @posts = load_posts(params[:term_slug], 'tag')
    render 'posts/index'
  end

  private

  def load_posts(slug, group)
    term = Term.includes(:posts).where(slug: slug, term_group: group)
    raise(ActiveRecord::RecordNotFound) unless term.first
    term.first.posts
  end

end
