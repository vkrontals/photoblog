class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :site_author

  private

  def site_author
    @author ||= User.find_by_slug('valters-krontals')
  end

end
