class Term < ActiveRecord::Base
  VALID_TERMS = %w[ tag category ]

   # id
   # name
   # slug
   # term_group

  has_and_belongs_to_many :posts, class_name: 'Post'

  validates :name, :slug, :term_group, presence: true
  validates :term_group, inclusion: VALID_TERMS
  validates :slug, uniqueness: true
end
