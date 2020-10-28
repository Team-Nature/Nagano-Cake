class Public::DeliveriesController < ApplicationController
  before_action :authenticate_customer!
  before_action :delete_session
  
  def index
    @delivery = current_customer.deliveries.new
    @deliveries = current_customer.deliveries.all
  end

  def create
    @delivery = current_customer.deliveries.new(delivery_params)
    if @delivery.save
      redirect_to deliveries_path, notice: "You have created book successfully."
    else
      @deliveries = current_customer.deliveries.all
      render 'index'
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to deliveries_path
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to deliveries_path, notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private
  def delivery_params
    params.require(:delivery).permit(:postcode, :address, :name)
  end


end
