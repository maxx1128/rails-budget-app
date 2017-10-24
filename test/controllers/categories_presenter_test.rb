# For presenting a single category

class CategoriesPresenterTest < ActionDispatch::IntegrationTest

  def setup
    @category_exp = categories(:food)
    @category_inc = categories(:salary)

    @presenter_exp = CategoriesPresenter.new(@category_exp)
    @presenter_inc = CategoriesPresenter.new(@category_inc)
  end

  test "should have an equal id" do
    assert_equal @category_exp.id, @presenter_exp.id
  end

  test "should have all related expenses" do
    assert_equal @presenter_exp.expenses.length, 5
    assert_equal @presenter_inc.expenses.length, 5
  end
  
  test "should get total" do
    assert_equal @presenter_exp.total, 350
    assert_equal @presenter_inc.total, 1750
  end

  test "should have the same budget" do
    assert_equal @category_exp.budget, @presenter_exp.budget
  end

  test "should return if it's an expense or income" do
    assert_equal @presenter_exp.type, "Expense"
    assert_equal @presenter_inc.type, "Income"
  end

  test "should calculate an accurate balance" do
    assert_equal @presenter_exp.balance[:total], -50
    assert_equal @presenter_exp.balance[:state], "negative"

    assert_equal @presenter_inc.balance[:total], 250
    assert_equal @presenter_inc.balance[:state], "positive"
  end
end
