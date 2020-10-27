class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @cart_items = current_customer.cart_items.all
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def create
    if customer_signed_in?
      if cart_item_params[:amount].blank?
        redirect_to item_path(cart_item_params[:item_id]), notice: "個数を選択してください"
      else
        @cart_items = current_customer.cart_items.new(cart_item_params)
        if @cart_items.save
          redirect_to cart_items_path
        end
      end
    else
      redirect_to new_customer_session_path
    end
  end

  def destroy
   cart_item = current_customer.cart_items.find(params[:id])
   cart_item.delete
   redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.each do |cart_item|
    cart_item.delete
  end
    redirect_to cart_items_path
  end

  protected
    def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
    end

end
