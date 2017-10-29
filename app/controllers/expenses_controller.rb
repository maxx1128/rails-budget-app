class ExpensesController < ApplicationController

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      year = params[:date][:year].to_i
      month = params[:date][:month].to_i
      new_date = DateTime.new(year, month, 1)
      @expense.created_at = new_date
      @expense.save
      
      flash[:success] = "Expense added!"
      redirect_to categories_url
    else
      flash[:failure] = "Expense failed to add"
      render '/expenses/new/'
    end
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update_attributes(expense_params)
      flash[:success] = "Expense updated!"
      redirect_to categories_url
    else
      render "/expenses/update/"
    end
  end

  def destroy
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :category_id, :value, :description)
  end
end
