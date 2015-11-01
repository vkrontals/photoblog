class Resources::ImagesHost

  attr_reader :data

  ExternalImage = Struct.new(:url, :last_modified, :size, :owner)

  def images
    @img || pull_latest
  end

  def pull_latest
    @img = external_images(Date.today).map do |row|
      Utils::ImagesBuilder.make_image({
        'url' => row.url,
        'uploaded_time' => row.last_modified
      })
    end

  end

  def external_images(date = nil)
    date ||= Date.today

    filter = date.strftime('%Y/%m/')
    puts "gathering images from: #{filter}"
    amazon_aws(filter)
  end

  private

  def amazon_aws(prefix)
    begin
      @s3 ||= Aws::S3::Client.new
      imgs = @s3.list_objects({
        bucket: Settings.aws.s3_bucket,
        delimiter: '/',
        #encoding_type: "url",
        #marker: "Marker",
        #max_keys: 1,
        prefix: prefix
      })

      imgs.contents.map do |x|
        if x.key.to_s.end_with? '.jpg'

          ExternalImage.new(
            x.key,
            x.last_modified,
            x.size,
            x.owner.display_name
          )
        end
      end.compact
    rescue
      raise Errors::ExternalImagesHostError
    end

  end

end
