require 'test_helper'

class ManageCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @category = Category.new(name: "Food", description: "Lorem ipsum dolor!")
  end

  test "add new category" do
    get "/categories/new"
    assert_template "categories/new"
    
    assert_difference 'Category.count', 1 do
      post categories_url, params: { category: { name: "Test category",
                                                 description: "Lorem ipsum dolor!" } }
    end

    follow_redirect!
    assert_template "categories/index"
    assert_not flash.empty?
  end

  test "edit category" do
    get "/categories/edit"
    assert_template "/categories/edit"

    # Finish this later!
  end
end
