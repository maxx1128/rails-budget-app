class MonthlyDataQuery < BaseQuery
  include CategoriesHelper

  def initialize(month=nil, year=nil, type=nil)
    @type = type
    dates = get_month_dates(month, year)

    @start_date = dates.start
    @end_date = dates.end
  end

  def categories
    Category.includes(:expenses)
      .where(expense: @type)
      .where(expenses: { created_at: @start_date..@end_date })
  end
end
