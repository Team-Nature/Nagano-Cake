class Admin::AdminsController < ApplicationController
  before_action :authenticte_admin!
  
  def top
  end
  
end
