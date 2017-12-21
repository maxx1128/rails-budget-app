class Category < ApplicationRecord
  include CategoriesHelper

  has_many :expenses,  dependent: :destroy

  validates :expense, :inclusion => {:in => [true, false]}
  
  validates :name, presence: true,
                   length: { maximum: 25 },
                   uniqueness: { case_sensitive: false }

  validates :budget, presence: true,
                     numericality: { only_integer: true,
                                     greater_than: 1 }

  before_save { self.name.capitalize! }

  def type
    category_type(expense)
  end

  def type_p
    type.pluralize(type)
  end
end
