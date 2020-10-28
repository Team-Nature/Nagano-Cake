class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :delete_keyword_session

  def index
    @orders = Order.order(id: :desc).page(params[:page]).per(10)
  end

  def today
    @orders = Order.today.page(params[:page]).per(10)
    render "index"
  end

  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
  end

  def update
    order = Order.find(params[:id])
    if order.update(order_params)
      if order.status == "入金確認"
        order.order_items.each do |order_item|
          order_item.update(status: "製作待ち")
        end
      end
      redirect_to admin_order_path(order)
    end
  end

  private
    def order_params
      params.require(:order).permit(:status)
    end

    def integer_string?(str)
      begin
        Integer(str)
        true
      rescue ArgumentError
        false
      end
    end

    def params_int(model_params)
      model_params.each do |key, val|
        if integer_string?(val)
          model_params[key] = val.to_i
        end
      end
    end
end
