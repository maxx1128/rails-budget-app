class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.string :name
      t.text :description
      t.integer :value
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
