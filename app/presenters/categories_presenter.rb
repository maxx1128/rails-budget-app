class CategoriesPresenter < BasePresenter
  include CategoriesHelper

  delegate :category,
           :name, 
           :description, 
           :expense, 
           :expenses, 
           :length,
           :budget, to: :@category

  def initialize(category = nil)
    @category = category
  end

  def id
    @category.id
  end

  def total
    category_total(@category.expenses)
  end

  def budget
    @category.budget
  end

  def type
    if @category.expense
      "Expense"
    else
      "Income"
    end
  end

  def type_p
    type.pluralize(type)
  end

  def balance
    if @category.expense
      total = @category.budget - category_total(@category.expenses)
    else
      total = category_total(@category.expenses) - @category.budget
    end

    {
      :total => total,
      :state => check_state(total)
    }
  end
end