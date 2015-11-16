module ApplicationHelper

  def image_host(url)
    Settings.images.server + url
  end

  def body_class
    @body_class.to_s.strip
  end

  def set_body_class(css_class)
    @body_class ||= ''
    @body_class += " #{css_class}"
  end

end
