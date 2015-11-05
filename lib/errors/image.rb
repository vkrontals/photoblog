module Errors::Image
  class UrlMissing < StandardError; end

  class UploadedTimeMissing < StandardError; end

  class InvalidDateTimeFormat < StandardError; end

  class ExternalImageHostError < StandardError; end

  class InvalidUrlFormat < StandardError; end

end
