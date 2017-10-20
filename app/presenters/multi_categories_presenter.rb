class MultiCategoriesPresenter < BasePresenter
  include CategoriesHelper

  include Enumerable

  def initialize(multi_category)
    @multi_category = multi_category
  end

  class << self
    def present(multi_category)
      new(multi_category)
    end
  end

  def each(&block)
    all_categories.each(&block)
  end

  def balances_calculator(type)
    if type == "expense"
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

    if type == "expense"
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

  def expense
    balances_calculator("expense")
  end

  def income
    balances_calculator("income")
  end

  def final_balance
    balance = expense[:balance] + income[:balance]

    {
      :total => h.number_to_currency(balance),
      :state => check_state(balance)
    }
  end

  private

  def all_categories
    @presented_category ||= @multi_category.map { |cat| CategoriesPresenter.new(cat) }
  end
end