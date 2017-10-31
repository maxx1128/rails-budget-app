# For presenting multiple categories

class MultiCategoriesPresenterTest < ActionDispatch::IntegrationTest
  def setup
    @all_categories = categories
    begin_time = DateTime.new(1000, 1, 1)
    end_time = DateTime.new(9999, 1, 1)

    @presenter = MultiCategoriesPresenter.new(categories, begin_time, end_time)
  end

  test "should have the same number of categories" do
    assert_equal @all_categories.length, @presenter.length
  end
end