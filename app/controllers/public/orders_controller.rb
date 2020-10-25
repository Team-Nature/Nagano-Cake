class Public::OrdersController < ApplicationController

  def new
  end

  def log
  end

  def create
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

end
