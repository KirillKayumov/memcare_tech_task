module V1
  class OrderSerializer < ActiveModel::Serializer
    attributes :id, :customer_name, :value, :created_at

    has_many :ordered_line_items

    def created_at
      object.created_at.iso8601
    end
  end
end
