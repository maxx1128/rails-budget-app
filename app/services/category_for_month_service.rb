class CategoryForMonthService < BaseService
  include CategoriesHelper

  delegate :category,
           :name, 
           :description, 
           :expense, 
           :type,
           :type_p,
           :expenses, 
           :length,
           :budget, to: :@category

  def initialize(id=nil, month=nil, year=nil)
    dates = get_month_dates(month, year)

    @start_date = dates.start
    @end_date = dates.end

    @category = Category.find(id)
  end

  def expenses
    @category.expenses.where(created_at: @start_date..@end_date)
  end

  def total
    h.category_total(expenses)
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

  def balance_total
    if @category.expense then (budget - total) else (total - budget) end
  end

  def balance_state
    h.check_state(balance_total)
  end
end