module V1
  class UpdateLineItem
    include Interactor

    delegate :line_item, :params, to: :context, private: true
    delegate :order, to: :line_item, private: true

    def call
      ApplicationRecord.transaction do
        update_line_item!
        update_order_value!
      end
    rescue ActiveRecord::RecordInvalid
      context.fail!
    end

    private

    def update_line_item!
      line_item.update!(params)
    end

    def update_order_value!
      return if order.update(value: new_order_value)

      line_item.errors.add(:order, order.errors)
      raise ActiveRecord::RecordInvalid
    end

    def new_order_value
      order.line_items.sum(:price)
    end
  end
end
