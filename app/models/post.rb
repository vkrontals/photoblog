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

  validates :content, :title, :publish_date, :permalink, :status, presence: true
  validates :permalink, uniqueness: true
end

