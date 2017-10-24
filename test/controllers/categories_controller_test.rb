class CategoriesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @category = categories(:food)
  end

  test "should show index" do
    get categories_url
    assert_template 'categories/index'
  end

  test "should get new" do
    get '/categories/new'
    assert_response :success
  end

  test "should show all categories after new one is added" do
    assert_difference 'Category.count', 1 do
      post categories_url, params: { category: { name: "New Category",
                                                 budget: 300,
                                                 description: "Lorem Ipsum" } }
    end

    assert_not flash.empty?
    assert_redirected_to categories_url
  end

  test "should stay on new category page when fails to add one" do
    assert_no_difference 'Category.count' do
      post categories_url, params: { category: { name: "New Category",
                                                 budget: -300,
                                                 description: "Lorem Ipsum" } }
    end

    assert_not flash.empty?
    assert_template 'categories/new'
  end

  test "should be able to delete categories" do
    assert_difference 'Category.count', -1 do
      delete category_path(@category)
    end

    assert_not flash.empty?
    assert_redirected_to categories_url
  end
end
