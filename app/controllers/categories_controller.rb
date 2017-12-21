class CategoriesController < ApplicationController
  include CategoriesHelper
  before_action :logged_in_user

  def index
    # TestMailer.header_test('Hello there header!').deliver_now

    begin_time = DateTime.new(1000, 1, 1)
    end_time = DateTime.new(9999, 1, 1)
    
    @title = "Categories"
    @calendar = MultiCategoriesPresenter.new(Category.all, begin_time, end_time)
  end

  def new
    @category = Category.new
  end

  def show
    id = params[:id]
    year = params[:year]
    month = params[:month]

    month_name = get_month_name(month)

    @title = "Budget for Category on #{month_name}, #{year}"
    @category = CategoryInMonthService.new(id, month, year)
  end

  def month
    year = params[:year]
    month = params[:month]

    month_dates = get_month_dates(year, month)
    month_name = get_month_name(month)
    categories = Category.all

    @all_categories = MultiCategoriesPresenter.new(categories, month_dates.start, month_dates.end)
    @title = "Budget for #{month_name}, #{year}"

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

  def category_params
    params.require(:category).permit(:name, :budget, :description)
  end
end
