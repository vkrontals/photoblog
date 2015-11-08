class User < ActiveRecord::Base

  # id
  # password_digest
  # email
  # url
  # display_name
  # created_at
  # updated_at

  has_secure_password

  has_many :posts

  validates :email, uniqueness: true
  validates :email, :display_name, presence: true

end
