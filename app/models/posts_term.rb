class PostsTerm < ActiveRecord::Base
  belongs_to :post
  belongs_to :term


end
