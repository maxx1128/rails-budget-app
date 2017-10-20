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
    h.number_to_currency(category_total(@category.expenses))
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
    total = @category.budget - category_total(@category.expenses)

    {
      :total => h.number_to_currency(total),
      :state => check_state(total)
    }
  end
end