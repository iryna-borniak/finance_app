class Operation < ApplicationRecord  
  belongs_to :category
  belongs_to :operation_type

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :odate, presence: true
  validates :description, presence: true

  paginates_per 2
end
