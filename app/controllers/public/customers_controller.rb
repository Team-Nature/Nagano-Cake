class Public::CustomersController < ApplicationController
  
  def show

   @customer = current_customer

  end
  
  def quit
  end
  
  def out
    @customer = current_customer
    @customer.update

    reset_session
    flash[:notice] = "またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end
  
  def edit
    @customer =current_customer
  end
  
  def update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name, :last_name_kana, :email, :postcode, :address, :tel)
  end

  
end