class CategoriesController < ApplicationController
  include CategoriesHelper
  before_action :logged_in_user

  def index
    begin_time = DateTime.new(1000, 1, 1)
    end_time = DateTime.new(9999, 1, 1)
    
    @title = "Categories"
    @calendar = MultiCategoriesPresenter.new(Category.all, begin_time, end_time)
  end

  def new
    @category = Category.new
  end

  def show
    time = get_time_info(params[:year], params[:month])
    category = Category.find(params[:id])

    @title = "Budget for Category on #{time[:month_name]}, #{time[:year]}"
    @category = CategoriesPresenter.new(category, time[:start_date], time[:end_date])
  end

  def month
    time = get_time_info(params[:year], params[:month])
    categories = Category.all

    @all_categories = MultiCategoriesPresenter.new(categories, time[:start_date], time[:end_date])

    @title = "Budget for #{time[:month_name]}, #{time[:year]}"
    render '/categories/month'
  end

  def edit
    @categories = Category.all.order({ expense: :desc })
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

  def get_time_info(url_year, url_month)
    year = url_year.to_i
    month = url_month.to_i
    start_date = DateTime.new(year, month, 1)

    {
      :year => year,
      :start_date => start_date,
      :end_date => start_date + 1.month,
      :month_name => start_date.strftime("%B")
    }
  end

  def category_params
    params.require(:category).permit(:name, :budget, :description)
  end
end
