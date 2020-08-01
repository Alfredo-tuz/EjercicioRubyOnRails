class Seller < ApplicationRecord
    validates :name, presence: true
    validates :direction, presence: true

end
