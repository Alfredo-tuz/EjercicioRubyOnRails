class Purchase < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  belongs_to :seller

  validates :customer, presence: true
  validates :product, presence: true
  validates :seller, presence: true
  validates :seller, presence: true
  validates :quantity, numericality: { only_integer: true }

end
