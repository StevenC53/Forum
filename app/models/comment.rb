class Comment < ApplicationRecord
  default_scope { order('updated_at DESC') }
  belongs_to :post
end
