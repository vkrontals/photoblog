class Image < ActiveRecord::Base
  # id
  # url
  # uploaded_time
  # alt_txt
  # caption
  # post_id
  # created_at
  # updated_at

  validates :url, :uploaded_time, presence: true
  validates :url, uniqueness: true

  def to_s
    "url: #{url}, uploaded: #{uploaded_time}"
  end

end
