class V1::ErrorSerializer < ActiveModel::Serializer::ErrorSerializer
  attributes :errors
end
