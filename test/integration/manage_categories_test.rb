require 'test_helper'

class ManageCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @category = Category.new(name: "Food", description: "Lorem ipsum dolor!")
  end
end
