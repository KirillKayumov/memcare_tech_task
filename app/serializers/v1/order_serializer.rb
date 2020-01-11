module V1
  class OrderSerializer < ActiveModel::Serializer
    attributes :id, :customer_name, :value
  end
end
