class CategoriesController < ApplicationController
  include CategoriesHelper

  def index
    @all_categories = MultiCategoriesPresenter.new(Category.all)
  end

  def new
    @category = Category.new
  end

  def show
    category = Category.find(params[:id])
    @category = CategoriesPresenter.new(category)
  end

  def edit
    @categories = Category.all
    render '/categories/edit'
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Category added!"
      redirect_to categories_url
    else 
      flash[:failure] = "Failed to add category!"
      render '/categories/new/'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category deleted!"
    redirect_to categories_url
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = "Category updated!"
      redirect_to categories_url
    else
      render "/categories/edit/"
    end
  end

  private
  def category_params
    params.require(:category).permit(:name, :budget, :description)
  end
end
