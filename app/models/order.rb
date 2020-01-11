class Order < ApplicationRecord
  validates :customer_name, presence: true, length: { maximum: 255 }
  validates :value, numericality: { greater_than_or_equal_to: 0 }
end
