class AddOperationTypeRecords < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          INSERT INTO operation_types (name, created_at, updated_at)
          VALUES ('дохід', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
                 ('витрата', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
        SQL
      end
    end
  end
end
