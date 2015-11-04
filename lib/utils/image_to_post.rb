require 'json'

module Utils
  class ImageToPost

    def self.make(image)
      url_data = extract_terms_string(image.url)

      image.attributes = {
        caption: url_data.join(' ').capitalize,
        alt_txt: url_data.join(' ').capitalize
      }

      tags = Utils::TermsBuilder.make_terms(url_data.join(', '), 'tag')
      categories = Utils::TermsBuilder.make_terms(guess_category(url_data.join(' ')), 'category')

      Post.new({
        content: "<p>#{ url_data.join(' ').capitalize }</p>",
        publish_date: '2015-08-13 09:00:00 UTC',
        # updated_at: "2015-08-21 15:58:26 UTC",
        title: url_data.join(' ').capitalize,
        excerpt: '',
        status: 'publish',
        permalink: url_data.join('-'),
        comment_count: 0,
        thumbnail: image,
        terms: tags + categories
      })
    end

    def self.extract_terms_string(url_string)
      regex = /^(\d{4}\/\d{2}\/)([a-z0-9-]*)(.jpg)$/

      url = url_string.to_s.downcase.match regex

      url[2].to_s.split('-')
    end

    def self.guess_category(string)
      case
      when string.include?('nikon'),
           string.include?('centon'),
           string.include?('minolta')
        '35mm'
      when string.include?('bronica')
        'medium format'
      else
        'uncategorized'
      end
    end

  end
end
