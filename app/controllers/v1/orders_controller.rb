module V1
  class OrdersController < ApplicationController
    before_action :load_order, only: %i[show update destroy]

    def index
      orders = Order.all.includes(:ordered_line_items).order(:id)

      render json: orders
    end

    def show
      render json: @order
    end

    def create
      order = Order.new(order_params)

      if order.save
        render json: order, status: :created
      else
        render json: order, status: :unprocessable_entity, serializer: ErrorSerializer
      end
    end

    def update
      if @order.update(order_params)
        render json: @order
      else
        render json: @order, status: :unprocessable_entity, serializer: ErrorSerializer
      end
    end

    def destroy
      if @order.destroy
        render json: @order
      else
        render json: @order, status: :unprocessable_entity, serializer: ErrorSerializer
      end
    end

    private

    def load_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:customer_name)
    end
  end
end
