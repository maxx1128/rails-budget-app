class Expense < ApplicationRecord
  belongs_to :category

  validates :category_id, presence: true

  validates :name, presence: true,
                   length: { maximum: 30 }

  validates :description, presence: true,
                          length: { maximum: 140 }

  validates :value, presence: true,
                    numericality: { only_integer: true,
                                    greater_than: 1 }
end
