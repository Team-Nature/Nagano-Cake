class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :delete_keyword_session
  
  def new
    @category_new = Category.new
    @categories = Category.all
  end
  
  def create
    @category_new = Category.new(category_params)
    if @category_new.save
      redirect_to new_admin_category_path
    else
      @categories = Category.all
      render "new"
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to new_admin_category_path
    else
      render "edit"
    end
  end
  
  private
    def category_params
      params.require(:category).permit(:name, :is_active)
    end
end
