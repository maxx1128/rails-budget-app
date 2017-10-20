require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase
  def setup
    @category = categories(:food)
    @expense = @category.expenses.build(name: "Groceries", description: "I had to buy food for the week!", value: 100)
    @income = @category.expenses.build(name: "Groceries", description: "I got paid!", value: 500)
  end

  test "should be valid" do
    assert @expense.valid?
    assert @income.valid?
  end

  test "should have a name" do
    @expense.name = "    "
    assert_not @expense.valid?
  end

  test "name shouldn't be longer than 30 characters" do
    @expense.name = "a" * 31
    assert_not @expense.valid?
  end


  test "should have a description" do
    @expense.description = "    "
    assert_not @expense.valid?
  end

  test "description shouldn't be longer than 140 characters" do
    @expense.name = "a" * 141
    assert_not @expense.valid?
  end

  test "should have a value" do
    @expense.value = "    "
    assert_not @expense.valid?
  end

  test "value should be a number" do
    @expense.value = "number"
    assert_not @expense.valid?
  end

  test "value shouldn't be zero" do
    @expense.value = 0
    assert_not @expense.valid?
  end
end
