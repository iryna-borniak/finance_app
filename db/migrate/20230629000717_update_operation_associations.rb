class UpdateOperationAssociations < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :operations, :categories
    remove_foreign_key :operations, :operation_types

    add_foreign_key :operations, :categories, on_delete: :cascade
    add_foreign_key :operations, :operation_types, on_delete: :cascade
  end
end
