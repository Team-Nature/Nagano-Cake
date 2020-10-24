class Admin::CustomersController < ApplicationController
  before_action :authenticte_admin!

  def update
    @customer = Customer.find(params[:id])  
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      render "edit"
    end
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def index
    @customers = Customer.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  private
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postcode, :address, :tel, :email, :is_active)
    end
end
