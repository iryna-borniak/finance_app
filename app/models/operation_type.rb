class OperationType < ApplicationRecord
  has_many :operations, dependent: :destroy
end
