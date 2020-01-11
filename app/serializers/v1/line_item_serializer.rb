module V1
  class LineItemSerializer < ActiveModel::Serializer
    attributes :id, :name, :price
  end
end
