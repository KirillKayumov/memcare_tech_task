class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  validates :customer_name, presence: true, length: { maximum: 255 }
  validates :value, numericality: { greater_than_or_equal_to: 0 }
end
