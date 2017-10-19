class AddBudgetToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :budget, :integer
  end
end
