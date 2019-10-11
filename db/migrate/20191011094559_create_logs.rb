class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.integer :year,      null: false
      t.bigint :population, null: false

      t.timestamps
    end
    add_index :logs, :year
  end
end
