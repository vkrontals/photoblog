require 'json'

module Utils
  class PostsJsonGenerator

    def self.generate(post)
<<POST
{
  "content": "#{ post.content.html_safe }",
  "publish_date": "#{ post.publish_date }",
  "updated": "#{ post.updated_at }",
  "title": "#{ post.title }",
  "excerpt": "#{ post.excerpt }",
  "status": "#{ post.status }",
  "permalink": "#{ post.permalink}",
  "comment_count": #{ post.comment_count },
  "thumbnail": {
    "caption": "#{ post.thumbnail.caption }",
    "alt_txt": "#{ post.thumbnail.alt_txt }",
    "uploaded_time": "#{ post.thumbnail.uploaded_time }",
    "url": "#{ post.thumbnail.url }"
  },
  "categories": "#{ generate_terms(post, :category)}",
  "tags": "#{ generate_terms(post, :tag) }"
}
POST
    end

    def self.generate_terms(post, term_type)
       post.terms
        .select{ |x| x.term_group == term_type.to_s }
        .map{ |x| x.name }.join(', ')
    end

  end

end
