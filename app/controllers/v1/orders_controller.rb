module V1
  class OrdersController < ApplicationController
    def index
      orders = Order.all.order(:id)

      render json: orders
    end

    def show
      order = Order.find(params[:id])

      render json: order
    end

    def create
      order = Order.create(order_params)

      render json: order
    end

    def update
      order = Order.update(order_params)

      render json: order
    end

    def destroy
      order = Order.find(params[:id])

      order.destroy

      render :no_content
    end

    private

    def order_params
      params.require(:order).permit(:customer_name)
    end
  end
end
