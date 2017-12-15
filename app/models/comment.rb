class Comment < ApplicationRecord
  default_scope { order('updated_at DESC') }
  belongs_to :post
  belongs_to :user
end

# Models are solid.  Nice work figuring out how to keep things in order.  Consider adding in validations as well for certain fields.  (Post/Comments must have a minimum length, presence must be true, etc)
