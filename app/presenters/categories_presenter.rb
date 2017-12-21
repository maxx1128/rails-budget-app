class CategoriesPresenter < BasePresenter

  delegate :category,
           :name, 
           :description, 
           :expense, 
           :type,
           :type_p,
           :expenses, 
           :length,
           :budget, to: :@category

  def initialize(category = nil, start_date = nil, end_date = nil)
    @category = category
    @start_date = start_date
    @end_date = end_date
  end
  
  def id          ; @category.id.to_i end
  def created_at  ; @category.created_at end
  def budget      ; @category.budget end
  def description ; @category.description end
  def type        ; @category.type end
  def type_p      ; @category.type_p end

  def total
    h.category_total(expenses)
  end

  def expenses
    expenses = @category.expenses.select { |expense| expense.created_at.between?(@start_date, @end_date) }.sort_by &:value
    expenses.reverse
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