class Admin::OrdersController < ApplicationController
  
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
  end
  
  def update
    order = Order.find(params[:id])
    if order.update(params_int(order_params))
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
