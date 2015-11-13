class Post < ActiveRecord::Base

  # id
  # author_id
  # content
  # publish_date
  # title
  # excerpt
  # status
  # permalink
  # comment_count
  # thumbnail
  # created_at
  # updated_at

  has_and_belongs_to_many :terms, class_name: 'Term'
  has_one :thumbnail, class_name: 'Image'
  belongs_to :author, class_name: 'User'
  accepts_nested_attributes_for :thumbnail

  validates :content, :title, :publish_date, :permalink, :status, presence: true
  validates :permalink, uniqueness: true

  # TODO permalink needs to be a valid url

  def to_param
    permalink
  end

  def to_json
<<POST
{
  "content": "#{ content.html_safe }",
  "publish_date": "#{ publish_date }",
  "updated": "#{ updated_at }",
  "title": "#{ title }",
  "excerpt": "#{ excerpt }",
  "status": "#{ status }",
  "permalink": "#{ permalink}",
  "comment_count": #{ comment_count },
  "thumbnail": {
    "caption": "#{ thumbnail.caption }",
    "alt_txt": "#{ thumbnail.alt_txt }",
    "uploaded_time": "#{ thumbnail.uploaded_time }",
    "url": "#{ thumbnail.url }"
  },
  "categories": "#{ generate_terms(:category)}",
  "tags": "#{ generate_terms(:tag) }"
}
POST
  end

  private

  def generate_terms(term_type)
    terms
      .select{ |x| x.term_group == term_type.to_s }
      .map{ |x| x.name }.join(', ')
  end

end

