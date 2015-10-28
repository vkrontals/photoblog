require 'json'

module Utils
  class PostsBuilder

  attr_reader :posts

  POSTS = File.read('lib/data/posts.json')

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
    author = User.last || add_user
    result = []
    posts.each do |post|
      new_post = Post.new(
        {
          author_id: author.id,
          content: post["content"],
          publish_date: post["publish_date"].to_date,
          title: post["title"],
          excerpt: post["excerpt"],
          status: post["status"],
          permalink: post["permalink"],
          comment_count: post["comment_count"],
          thumbnail: Image.new({ url: post["thumbnail"], uploaded_time: Date.today }),
          updated_at: post["updated"].to_date
        }
      )
      new_post.save!

      result << new_post

    end

    result
  end

  def add_user
    User.new({
               email: 'v.krontals@gmail.com',
               url: '',
               display_name: 'Valters Krontals',
               password: 'password1'
             }).save

    User.last
  end

  end
end
