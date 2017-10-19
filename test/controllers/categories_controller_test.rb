require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get categories_new_url
    assert_response :success
  end

  test "should get delete" do
    get categories_delete_url
    assert_response :success
  end

  test "should get update" do
    get categories_update_url
    assert_response :success
  end

end
