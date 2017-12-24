module ExpensesHelper
  def get_expense_category_page(expense)
    year = expense.created_at.strftime("%Y")
    month = expense.created_at.strftime("%-m")
    category_id = expense.category_id

    "/categories/#{year}/#{month}/#{category_id}/"
  end

  def expense_date(month, year)
    DateTime.new(year, month, 1)
  end
end
