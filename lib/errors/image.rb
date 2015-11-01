module Errors::Image
  class UrlMissing < StandardError; end

  class UpdatedTimeMissing < StandardError; end

  class InvalidDateTimeFormat < StandardError; end

  class ExternalImageHostError < StandardError; end

end
