class RedirectsController < ApplicationController

  def external_images_host
    image_path = params[:image_path].to_s.split('-1280').first
    image_path = image_path.split('-1024').first
    redirect_to Settings.images.server + image_path + '.' + params[:format], status: 301
  end

end
