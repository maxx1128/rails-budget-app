class CategoryForMonthService < BaseService

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
    @start_date = DateTime.new(year.to_i, month.to_i, 1)
    @end_date = @start_date + 1.month

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