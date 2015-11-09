class TermsController < ApplicationController
  def category
    @posts = load_posts(params[:term_slug], 'category')
    @nav = OpenStruct.new(
      {
        previous: (category_page_url(params[:term_slug], @posts.prev_page) unless @posts.first_page?),
        next: (category_page_url(params[:term_slug], @posts.next_page) unless @posts.last_page?),
        current: @posts.current_page,
        pages: (1..@posts.total_pages).map {|x| category_page_url(params[:term_slug], x) }
      })

    render 'posts/index'
  end

  def tag
    @posts = load_posts(params[:term_slug], 'tag')
    @nav = OpenStruct.new(
      {
        previous: (tag_page_url(params[:term_slug], @posts.prev_page) unless @posts.first_page?),
        next: (tag_page_url(params[:term_slug], @posts.next_page) unless @posts.last_page?),
        current: @posts.current_page,
        pages: (1..@posts.total_pages).map {|x| tag_page_url(params[:term_slug], x) }
      })
    render 'posts/index'
  end

  private

  def load_posts(slug, group)
    term = Term.find_by_slug(slug)
    raise(ActiveRecord::RecordNotFound) unless term
    term.posts.order(publish_date: :desc).page(params[:page].to_i)
  end

end
