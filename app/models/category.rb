class Category < ApplicationRecord
  has_many :expenses,  dependent: :destroy

  validates :name, presence: true,
                   length: { maximum: 25 },
                   uniqueness: { case_sensitive: false }

  validates :budget, presence: true,
                     numericality: { only_integer: true,
                                     greater_than: 1 }

  before_save { self.name.capitalize! }
end
