class ChangeYearToYearNumberOnPopulation < ActiveRecord::Migration[5.2]
  # Though it may convenient down the road to store #year as a date, right now the app's functionality
  # does not take advantage of this, so we're changing it to #year_number. When it is re-introduced,
  # it would be better to call it e.g. #date_of_year -- i.e. imply the data type in the field name.
  def up
    add_column :populations, :year_number, :integer, null: true

    # Changing data in a migration? Always use SQL. This avoids issues where future model changes may render
    # your migration broken in the future if you used the model as a data-changing dependency.
    execute("UPDATE populations SET year_number = strftime('%Y', year)")
    change_column :populations, :year_number, :integer, null: false

    remove_column :populations, :year
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
