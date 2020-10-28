class Admin::AdminsController < ApplicationController
  before_action :authenticate_admin!
  before_action :delete_keyword_session, only: [:top]
  
  def top
    @count = Order.where("created_at >= ?", Date.today).count
  end
  
  def result
    keyword =session[:keyword]
    unless keyword.blank?
      if Customer.by_last_name(keyword).any?
        @customers = Customer.by_last_name(keyword).page(params[:page])
        @resources = @customers
        flash.now[:notice] = "Found #{ @resources.count } #{ "person".pluralize(@resources.count)}"
      elsif Customer.by_first_name(keyword).any?
        @customers = Customer.by_first_name(keyword).page(params[:page])
        @resources = @customers
        flash.now[:notice] = "Found #{ @resources.count } #{ "person".pluralize(@resources.count)}"
      elsif Item.by_name(keyword).any?
        @items = Item.by_name(keyword).page(params[:page])
        @resources = @items
        flash.now[:notice] = "Found #{ @resources.count } #{ "item".pluralize(@resources.count) }"
      else
       flash.now[:notice] = "Nothing found"
      end
    else
      flash.now[:notice] =  "キーワードが必要です。"
    end
  end

  def search
    keyword = search_params[:keyword]
    session[:keyword] = keyword
    unless keyword.blank?
      if Customer.by_last_name(keyword).any?
        @customers = Customer.by_last_name(keyword).page(params[:page])
        flash.now[:notice] = "Found #{ @customers.count } #{ "person".pluralize(@customers.count)}"
        render "admin/customers/index"
      elsif Customer.by_first_name(keyword).any?
        @customers = Customer.by_first_name(keyword).page(params[:page])
        flash.now[:notice] = "Found #{ @customers.count } #{ "person".pluralize(@customers.count)}"
        render "admin/customers/index"
      elsif Item.by_name(keyword).any?
        @items = Item.by_name(keyword).page(params[:page])
        flash.now[:notice] = "Found #{ @items.count } #{ "item".pluralize(@items.count) }"
        render "admin/items/index"
      else
        redirect_to request.referer, notice: "Nothing found"
      end
    else
      redirect_to request.referer, notice: "キーワードが必要です。"
    end
  end

  private
    def search_params
      params.require(:search).permit(:keyword)
    end
end
