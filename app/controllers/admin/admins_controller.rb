class Admin::AdminsController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @count = Order.where("created_at >= ?", Date.today).count
  end
  
end
