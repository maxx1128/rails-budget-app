require 'test_helper'

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @expense = expenses(:log_11)
    @category = categories(:food)
  end

  test "should go back to category page after expense is added" do    
  end
  
  test "should go back to category page after expense is deleted" do
  end
end
