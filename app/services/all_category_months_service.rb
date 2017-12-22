class AllCategoryMonthsService < BaseService
  
  def initialize
    @categories = Category.includes(:expenses)
  end

  MonthLink = Struct.new(:month, :year, :month_name) do
    def link
      "categories/#{year}/#{month}"
    end

    def label
      "#{month_name} #{year}"
    end
  end

  def all
    dates = []

    @categories.each do |category|
      category.expenses.each do |expense|
        month = expense.created_at.strftime("%-m")
        year = expense.created_at.strftime("%Y")
        month_name = expense.created_at.strftime("%B")

        date_item = MonthLink.new(month, year, month_name)

        dates.push(date_item)
      end
    end

    dates.uniq
  end
end
