class LineItem < ApplicationRecord
  belongs_to :order

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { scope: :order }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
