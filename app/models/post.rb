class Post < ActiveRecord::Base

  has_and_belongs_to_many :terms, class_name: 'Term'
  has_one :thumbnail, class_name: 'Image'
  belongs_to :author, class_name: 'User'

end

