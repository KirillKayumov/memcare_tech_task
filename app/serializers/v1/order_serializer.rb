module V1
  class OrderSerializer < ActiveModel::Serializer
    attributes :customer_name, :value
  end
end
