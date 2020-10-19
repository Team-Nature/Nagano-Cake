class Public::DeliveriesController < ApplicationController
  
  def index
    @deliveries = Delivery.all
  end
  
  def create
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
