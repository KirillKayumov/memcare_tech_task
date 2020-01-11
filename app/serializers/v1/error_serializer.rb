module V1
  class ErrorSerializer < ActiveModel::Serializer::ErrorSerializer
    attributes :errors
  end
end
