class User < ActiveRecord::Base

  # id
  # password_digest
  # email
  # url
  # slug
  # display_name
  # created_at
  # updated_at

  has_secure_password

  has_many :posts

  validates :email, :slug, uniqueness: true
  validates :email, :slug, :display_name, presence: true

  def to_param
    slug
  end

end
