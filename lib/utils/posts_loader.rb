require 'json'

class Utils::PostsLoader

  attr_reader :posts

  POSTS = File.read('lib/data/posts.json')

  def initialize(json_data)
    @posts = Array(JSON.parse(json_data))
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

    p User.count

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
