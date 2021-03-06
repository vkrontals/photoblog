require 'json'

module Utils
  class PostsBuilder

    attr_reader :posts

    def initialize(json_data)
      @posts = Array(JSON.parse(json_data))
    end

    def self.make_post(post_hash)
      tags       = Utils::TermsBuilder.make_terms(post_hash['tags'], 'tag')
      categories = Utils::TermsBuilder.make_terms(post_hash['categories'], 'category')
      terms = tags + categories
      Post.new(
        {
          author_id:     1,
          content:       post_hash['content'],
          publish_date:  post_hash['publish_date'].to_datetime,
          title:         post_hash['title'],
          excerpt:       post_hash['excerpt'],
          status:        post_hash['status'],
          permalink:     post_hash['permalink'],
          comment_count: post_hash['comment_count'],
          thumbnail:     Utils::ImagesBuilder.make_image(post_hash['thumbnail']),
          updated_at:    post_hash['updated'].to_datetime,
          terms:         terms
        }
      )
    end

    def postify
      result = []
      errors = []

      posts.each do |post|
        begin
          new_post = Utils::PostsBuilder.make_post(post)
          new_post.save!

          result << new_post
        rescue
          errors << "#{$!}"
        end

      end
      puts errors.join("\n").red if errors.any?
      result
    end

  end
end
