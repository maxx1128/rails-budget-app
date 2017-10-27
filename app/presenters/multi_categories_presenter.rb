class MultiCategoriesPresenter < BasePresenter
  include CategoriesHelper
  include Enumerable

  attr_reader :expense, :income, :final_balance

  def initialize(multi_category, start_date, end_date)
    @multi_category = multi_category
    @start_date = start_date
    @end_date = end_date
  end

  class << self
    def present(multi_category)
      new(multi_category)
    end
  end

  def length
    all_categories.length
  end

  def each(&block)
    all_categories.each(&block)
  end

  def expense
    balances_calculator("Expense")
  end

  def income
    balances_calculator("Income")
  end

  def final_balance
    balance = expense[:balance] + income[:balance]
    profit = income[:total] - expense[:total]

    {
      :balance => balance,
      :balance_state => check_state(balance),
      
      :profit => profit,
      :profit_state => check_state(profit)
    }
  end

  def diff_date_ranges
    date_ranges = []
    income_cats = income[:all]
    expense_cats = expense[:all]

    all_cats = income_cats.zip(expense_cats).flatten.compact

    all_cats.each do |category|
      category.expenses.each do |exp|
        month = exp.created_at.strftime("%-m")
        year = exp.created_at.strftime("%Y")
        month_name = exp.created_at.strftime("%B")
        
        date_info = { :date => "#{year}/#{month}",
                      :label => "#{month_name} #{year}" }

        date_ranges.push(date_info)
      end
    end

    date_ranges.uniq
  end

  private

  def balances_calculator(type)
    if type == "Expense"
      categories = all_categories.select { |cat| cat.expense }
    else
      categories = all_categories.select { |cat| !cat.expense }
    end

    expected = 0
    total = 0

    categories.each do |cat|
      expected += cat.budget

      total += category_total(cat.expenses)
    end

    if type == "Expense"
      balance = expected - total
    else
      balance = total - expected
    end

    status = check_state(balance)

    {
      :type => type,
      :all => categories,
      :expected => expected,
      :total => total,
      :balance => balance,
      :status => status
    }
  end

  def all_categories
    @presented_category ||= @multi_category.map { |cat| CategoriesPresenter.new(cat, @start_date, @end_date) }
  end
end