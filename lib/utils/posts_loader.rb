require 'json'

class Utils::PostsLoader

  attr_reader :posts

  POSTS = File.read('lib/data/posts.json')

  def initialize(json_data)
    @posts = Array(JSON.parse(json_data))
  end

  def self.make_post(post_hash)
    tags = make_terms(post_hash['tags'], 'tag')
    categories = make_terms(post_hash['categories'], 'category')
    terms = tags + categories
    Post.new(
      {
        author_id: 1,
        content: post_hash['content'],
        publish_date: post_hash['publish_date'].to_datetime,
        title: post_hash['title'],
        excerpt: post_hash['excerpt'],
        status: post_hash['status'],
        permalink: post_hash['permalink'],
        comment_count: post_hash['comment_count'],
        thumbnail: make_image(post_hash['thumbnail']),

        updated_at: post_hash['updated'].to_datetime,
        terms: terms
      }
    )
  end

  def self.make_image(image_hash)

    images = Image.where('id = ? or url = ?', image_hash['id'], image_hash['url'])

    if images.empty?
      Image.new({
                url: image_hash['url'],
                uploaded_time: image_hash['uploaded_time'].to_datetime,
                caption: image_hash['caption'],
                alt_txt: image_hash['alt_txt']
              })
    else
      images.first
    end

  end

  def self.make_terms(term_string, term_type)
    term_array = term_string.split(',').map(&:strip)

    term_array.map do |term_element|
      Utils::PostsLoader.make_term term_element, term_type
    end

  end

  def self.make_term(term_string, term_group)
    Term.find_by_slug(term_string.parameterize) ||
      Term.new({
                 name: term_string,
                 slug: term_string.parameterize,
                 term_group: term_group
               })
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
