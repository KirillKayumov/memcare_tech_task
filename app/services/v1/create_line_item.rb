module V1
  class CreateLineItem
    def initialize(params:, order:)
      @params = params
      @order = order
    end

    def call
      create_line_item do |line_item|
        update_order_value(line_item)
      end
    end

    private

    attr_reader :params, :order

    def create_line_item
      line_item = order.line_items.create(params)

      yield(line_item) if line_item.persisted?

      line_item
    end

    def update_order_value(line_item)
      order.update!(value: order.value + line_item.price)
    end
  end
end
