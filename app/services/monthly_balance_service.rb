class MonthlyBalanceService < BaseService
  def initialize(month=nil, year=nil)
    @month = month
    @year = year

    @expenses = MonthlyCategoriesSummaryService.new(@month, @year, true)
    @incomes = MonthlyCategoriesSummaryService.new(@month, @year, false)
  end

  def expenses
    @expenses
  end

  def incomes
    @incomes
  end

  def top_expenses
    all_expenses = []

    expenses.categories.each do |category|
      category.expenses.each do |expense|  
        all_expenses.push(expense)
      end      
    end

    sorted_expenses = all_expenses.sort_by &:value
    top_expenses = sorted_expenses.reverse[0..4]
  end

  def balance
    @expenses.balance + @incomes.balance
  end

  def balance_state
    h.check_state(balance)
  end

  def profit
    @incomes.total - @expenses.total
  end

  def profit_state
    h.check_state(profit)
  end
end
