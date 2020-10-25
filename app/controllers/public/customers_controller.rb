class Public::CustomersController < ApplicationController

  def show
   @customer = current_customer
  end

  def quit
  end

  def out
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_path(@customer), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name, :last_name_kana, :email, :postcode, :address, :tel)
  end


end