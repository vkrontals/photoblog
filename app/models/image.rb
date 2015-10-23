class Image < ActiveRecord::Base

  attr_accessor :url,
                :uploaded_time,
                :alt_txt,
                :caption

end
