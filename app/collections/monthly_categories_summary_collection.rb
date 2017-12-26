class MonthlyCategoriesSummaryCollection < BaseCollection

  def initialize(month=nil, year=nil, type=nil)
    @month = month
    @year = year
    @type = type
    @categories = MonthlyDataQuery.new(month, year, type)
  end

  def categories
    @categories.categories.map do |category|
      CategoryForMonthCollection.new(category.id, @month, @year)
    end
  end

  def type
    h.category_type(@type)
  end

  def type_p
    type.pluralize(type)
  end

  def budget
    budget = 0
    categories.each do |cat|
      budget += cat.budget
    end

    budget
  end

  def total
    total = 0
    categories.each do |cat|
      total += h.category_total(cat.expenses)
    end

    total
  end

  def balance
    balance = if @type
      budget - total
    else
      total - budget
    end

    balance
  end

  def status
    h.check_state(balance)
  end
end
