class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end
    
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Your category was saved"
      redirect_to root_path
    else
      render "new"
    end
  end
   
  def show
    @category = Category.find(params[:id])
  end

  private
  
  def category_params # SO YOU CAN USE THE FIELD ON THE FORMS
    params.require(:category).permit(:name)
  end

  
end
