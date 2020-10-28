class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :delete_keyword_session

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end

  def create
    params = item_params
    params[:category] = Category.find_by(name: item_params[:category])
    @item = Item.new(params)
    if @item.save(params)
      redirect_to admin_item_path(@item[:id])
    else
      render "new"
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    params = item_params
    params[:category] = Category.find(item_params[:category])
    if @item.update(params)
      redirect_to admin_item_path(@item)
    else
      render "edit"
    end
  end

  private
    def item_params
      params.require(:item).permit(:image, :name, :description, :category, :price, :is_active)
    end

end
