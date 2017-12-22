module CategoriesHelper
  def category_total(transaction)
    total = 0

    transaction.each { |trans| total += trans.value }

    total
  end

  def get_month_name(month_number)
    fake_date = DateTime.new(2015, month_number.to_i, 1)
    fake_date.strftime("%B")
  end

  def get_month_dates(year, month)
    full_date = DateTime.new(year.to_i, month.to_i, 1)

    get_dates = Struct.new(:start) do
      def end
        start + 1.month
      end
    end

    get_dates.new(full_date)
  end

  def money_to_int(val)
    val.gsub(/\D/,'').to_i
  end

  def check_state(int)
    (int > 0) ? "positive" : "negative"
  end

  def category_type(category)
    if category then "Expense" else "Income" end
  end
end


