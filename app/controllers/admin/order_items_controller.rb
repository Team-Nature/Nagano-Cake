class Admin::OrderItemsController < ApplicationController

  def update
    order_itme = OrderItem.find(params[:id])
    if order_item.update(order_item_params)
      redirect_to admin_order_path(params[:order_id])
    end
  end
  
  private
    def order_item_params
      params.require(:order_item).permit(:status)
    end

end
