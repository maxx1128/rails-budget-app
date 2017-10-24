# For presenting multiple categories

class MultiCategoriesPresenterTest < ActionDispatch::IntegrationTest
  def setup
    @all_categories = categories

    @presenter = MultiCategoriesPresenter.new(@all_categories)
  end

  test "should have the same number of categories" do
    assert_equal @all_categories.length, @presenter.length
  end
end