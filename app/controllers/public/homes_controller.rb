class Public::HomesController < ApplicationController
  before_action :delete_session
  
  def top
    @items = Item.all
  end

  def about
  end

end
