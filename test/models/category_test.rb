require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  def setup
    @category = categories(:food)
  end

  test "should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = "      "
    assert_not @category.valid?
  end

  test "name should be capitalized after save" do
    mixed_category_name = "long FOOD CATEgory"
    @category.name = mixed_category_name
    @category.save
    assert_equal mixed_category_name.capitalize, @category.reload.name
  end

  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "name should be unique" do
    duplicate_category = @category.dup
    @category.save
    assert_not duplicate_category.valid?
  end

  test "budget should be present" do
    @category.budget = "    "
    assert_not @category.valid?
  end

  test "budget should be a number" do
    @category.budget = "number"
    assert_not @category.valid?
  end

  test "budget shouldn't be zero" do
    @category.budget = 0
    assert_not @category.valid?
  end

  test "budget shouldn't be negative" do
    @category.budget = -200
    assert_not @category.valid?
  end
end
