class Public::OrdersController < ApplicationController

  def new
    @order = current_customer.orders.new
  end

  def log

    @order = current_customer.orders.new
    @order_items = current_customer.cart_items
    @order.how_to_pay = order_params[:how_to_pay]
    if order_params[:addresses] == "address"
      @order.deliver_postcode = current_customer.postcode
      @order.deliver_address = current_customer.address
      @order.deliver_name = current_customer.full_name
    elsif order_params[:addresses] == "deliver_address"
      # address = order_params[select_address].split
      address = Delivery.find(order_params[:select_address])
      @order.deliver_postcode = address.postcode
      @order.deliver_address = address.address
      @order.deliver_name = address.name
    else
    @order.deliver_postcode = order_params[:deliver_postcode]
    @order.deliver_address = order_params[:deliver_address]
    @order.deliver_name = order_params[:deliver_name]
    end
    session[:how_to_pay] = @order.how_to_pay
    session[:deliver_postcode] = @order.deliver_postcode
    session[:deliver_address] = @order.deliver_address
    session[:deliver_name] = @order.deliver_name
    session[:addresses] = order_params[:addresses]



  end

  def create
    @order = current_customer.orders.new
    @order.set_order_items
    @order.how_to_pay = session[:how_to_pay]
    @order.deliver_postcode = session[:deliver_postcode]
    @order.deliver_address = session[:deliver_address]
    @order.deliver_name = session[:deliver_name]
    @order.get_total_price
    @order.deliver_fee = 800
    @order_items = @order.order_items
    if @order.save
      current_customer.cart_items.destroy_all
      session.delete(:how_to_pay)
      session.delete(:deliver_postcode)
      session.delete(:deliver_address)
      session.delete(:deliver_name)
      redirect_to thanks_path
    else
      render "log"
    end

  end

  def thanks
  end

  def index
  end

  def show
  end

protected
  def order_params
    params.require(:order).permit(:how_to_pay, :address_where, :address_select, :deliver_postcode, :deliver_address, :deliver_name, :addresses, :select_address)
  end

end
