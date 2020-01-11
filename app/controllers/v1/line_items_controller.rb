module V1
  class LineItemsController < ApplicationController
    before_action :load_order
    before_action :load_line_item, only: %i[show update destroy]

    def index
      line_items = @order.line_items.order(:id)

      render json: line_items
    end

    def show
      render json: @line_item
    end

    def create
      line_item = CreateLineItem.new(params: line_item_params, order: @order).call

      if line_item.persisted?
        render json: line_item, status: :created
      else
        render json: line_item, status: :unprocessable_entity, serializer: ErrorSerializer
      end
    end

    def update
      @line_item.update(line_item_params)

      render json: line_item
    end

    def destroy
      @line_item.destroy!

      render :no_content
    end

    private

    def load_order
      @order = Order.find(params[:order_id])
    end

    def load_line_item
      @line_item = @order.line_items.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:name, :price)
    end
  end
end
