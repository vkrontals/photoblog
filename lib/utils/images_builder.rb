module Utils
  module ImagesBuilder

    def self.make_image(image_hash)
      raise Errors::Image::UrlMissing if image_hash['url'].blank?
      raise Errors::Image::UpdatedTimeMissing if image_hash['uploaded_time'].blank?

      begin
        uploaded_time = image_hash['uploaded_time'].to_datetime

      rescue ArgumentError
        raise Errors::Image::InvalidDateTimeFormat
      end

      images = Image.where('id = ? or url = ?', image_hash['id'], image_hash['url'])

      if images.empty?
        Image.new({
                    url: image_hash['url'],
                    uploaded_time: uploaded_time,
                    caption: image_hash['caption'],
                    alt_txt: image_hash['alt_txt']
                  })
      else
        images.first
      end

    end

  end

end
