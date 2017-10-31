# For presenting a single category

class CategoriesPresenterTest < ActionDispatch::IntegrationTest

  def setup
    @category_exp = categories(:food)
    @category_inc = categories(:salary)
    begin_time = DateTime.new(1000, 1, 1)
    end_time = DateTime.new(9999, 1, 1)

    @presenter_exp = CategoriesPresenter.new(@category_exp, begin_time, end_time)
    @presenter_inc = CategoriesPresenter.new(@category_inc, begin_time, end_time)
  end

  test "should have an equal id" do
    assert_equal @category_exp.id, @presenter_exp.id
  end

  test "should have all related expenses" do
    assert_equal @presenter_exp.expenses.length, 5
    assert_equal @presenter_inc.expenses.length, 5
  end

  test "should have the same budget" do
    assert_equal @category_exp.budget, @presenter_exp.budget
  end

  test "should return if it's an expense or income" do
    assert_equal @presenter_exp.type, "Expense"
    assert_equal @presenter_inc.type, "Income"
  end
end
