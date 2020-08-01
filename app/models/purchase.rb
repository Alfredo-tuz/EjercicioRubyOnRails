class Purchase < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  belongs_to :seller
end
