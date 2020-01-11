module V1
  class LineItemSerializer < ActiveModel::Serializer
    attributes :name, :price
  end
end
