class CategoriesPresenter < BasePresenter
  include CategoriesHelper

  delegate :category,
           :name, 
           :description, 
           :expense, 
           :expenses, 
           :length,
           :budget, to: :@category

  def initialize(category = nil, start_date = nil, end_date = nil)
    @category = category
    @start_date = start_date
    @end_date = end_date
  end

  def id
    @category.id.to_i
  end

  def created_at
    @category.created_at
  end

  def budget
    @category.budget
  end

  def total
    category_total(expenses)
  end

  def expenses
    expenses = @category.expenses.select { |expense| expense.created_at.between?(@start_date, @end_date) }.sort_by &:value
    expenses.reverse
  end

  def type
    if @category.expense
      "Expense"
    else
      "Income"
    end
  end

  def type_p
    type.pluralize(type)
  end



  def date_link
    year = @start_date.strftime("%Y")
    month = @start_date.strftime("%-m")

    "#{year}/#{month}/#{@category.id}"
  end

  def month_link
    year = @start_date.strftime("%Y")
    month = @start_date.strftime("%-m")

    "/categories/#{year}/#{month}/"
  end

  def balance
    if @category.expense
      total = @category.budget - category_total(expenses)
    else
      total = category_total(expenses) - @category.budget
    end

    {
      :total => total,
      :state => check_state(total)
    }
  end
end