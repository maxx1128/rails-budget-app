class MonthlyDataQuery < BaseQuery

  # MonthlyDataQuery.new(10, 2017, true)

  def initialize(month=nil, year=nil, type=nil)
    @type = type
    @start_date = DateTime.new(year.to_i, month.to_i, 1)
    @end_date = @start_date + 1.month
  end

  def categories
    Category.includes(:expenses)
      .where(expense: @type)
      .where(expenses: { created_at: @start_date..@end_date })
  end
end
