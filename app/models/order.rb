class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :ordered_line_items, -> { order(:id) }, class_name: "LineItem"

  validates :customer_name, presence: true, length: { maximum: 255 }
  validates :value, numericality: { greater_than_or_equal_to: 0 }
end
