class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :delete_keyword_session

  def update
    order_item = OrderItem.find(params[:id])
    order = order_item.order
    if order_item.update(order_item_params)
      unless order.order_items.any? { |order_item| order_item.status != "製作完了" }
        order.update(status: "発送準備中")
      end
      redirect_to admin_order_path(order)
    end
  end
  
  private
    def order_item_params
      params.require(:order_item).permit(:status)
    end
end
