class Public::DeliveriesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @deliveries = Delivery.all
    @delivery = Delivery.new
  end
  
  def create
    @delivery = Delivery.new
    if @delivery.save
      redirect_to deliveries_path, notice: "You have created book successfully."
    else
      @deliveries = Delivery.all
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
    if @delivery.update(delivery_params)
      redirect_to delivery_path(@delivery), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

end
