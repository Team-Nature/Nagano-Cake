class Public::CustomersController < ApplicationController
  
  def show
<<<<<<< HEAD
    @customer = Customer.find(params[:id])
=======
   @customer = current_customer
>>>>>>> 10e89da08724156e6c66bdec4126851e0a383dd9
  end
  
  def quit
  end
  
  def out
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