class ExpensesController < ApplicationController
  include ExpensesHelper
  before_action :logged_in_user

  def new
    @expense = Expense.new
  end

  def new_in_category
    id = params[:id].to_i
    year = params[:year].to_i
    month = params[:month].to_i
    
    @expense = Expense.new
    @expense_date = expense_date(month, year)
    @category_id = id

    render '/expenses/new/'
  end

  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      year = params[:date][:year].to_i
      month = params[:date][:month].to_i
      
      new_date = expense_date(month, year)
      @expense.created_at = new_date
      @expense.save

      category_url = get_expense_category_page(@expense)
      
      flash[:success] = "Expense added!"
      redirect_to category_url
    else
      flash[:failure] = "Expense failed to add"
      render '/expenses/new/'
    end
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    category_url = get_expense_category_page(@expense)
    
    if @expense.update_attributes(expense_params)
      flash[:success] = "Expense updated!"
    else
      flash[:failure] = "Expense failed to update!"
    end

    redirect_to category_url
  end

  def destroy
    @expense = Expense.find(params[:id])
    category_url = get_expense_category_page(@expense)
    @expense.destroy
    
    flash[:success] = "Expense deleted!"
    redirect_to category_url
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :category_id, :value, :description)
  end
end
