class AddReqestTypeToLog < ActiveRecord::Migration[5.2]
  def change
    add_column :logs, :request_type, :integer
  end
  add_index :logs, :request_type
end
