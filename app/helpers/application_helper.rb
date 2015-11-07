module ApplicationHelper

  def image_host(url)
    Settings.images.server + url
  end

end
