class Term < ActiveRecord::Base

  has_and_belongs_to_many :posts, class_name: 'Post'
end