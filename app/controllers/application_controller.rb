class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :site_author
  before_action :strip_cookie
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound,   with: :render_404

  private

  def strip_cookie
    request.session_options[:skip] = true
  end

  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404: #{exception.message}"
    end

    render :file => "#{Rails.root}/public/404.html", status: 404, layout: false
  end

  def site_author
    @author ||= User.find_by_slug('valters-krontals')
  end

  def default_url_options
    if Rails.env.production?
      Rails.application.routes.default_url_options = { host: "thatcameraguy.co.uk", protocol: 'https' }
    end
  end
end
