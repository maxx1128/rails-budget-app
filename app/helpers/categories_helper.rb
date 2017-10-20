module CategoriesHelper
  def category_total(transaction)
    total = 0

    transaction.each { |trans| total += trans.value }

    total
  end

  def money_to_int(val)
    val.gsub(/\D/,'').to_i
  end

  def check_state(int)
    (int > 0) ? "positive" : "negative"
  end
end


