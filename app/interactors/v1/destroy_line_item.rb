module V1
  class DestroyLineItem
    include Interactor

    delegate :line_item, to: :context, private: true
    delegate :order, to: :line_item, private: true

    def call
      ApplicationRecord.transaction do
        line_item.destroy!
        update_order_value!
      end
    rescue ActiveRecord::RecordInvalid
      context.fail!
    end

    private

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
