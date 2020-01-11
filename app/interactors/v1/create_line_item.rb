module V1
  class CreateLineItem
    include Interactor

    delegate :params, :order, :line_item, to: :context, private: true

    def call
      ApplicationRecord.transaction do
        create_line_item!
        update_order_value!
      end
    rescue ActiveRecord::RecordInvalid
      context.fail!
    end

    private

    def create_line_item!
      context.line_item = order.line_items.build(params)

      line_item.save!
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
