class CreatePopulationInquiryLogItems < ActiveRecord::Migration[5.2]
  def change
    create_table :population_inquiry_log_items do |t|
      t.string :request_year_raw
      t.integer :request_valid_year

      t.string :response_status, null: false # this is basically an enum; your author is not a fan of Rails' default of using integers, since they make debugging a lot harder
      t.bigint :response_population

      t.timestamps
    end
  end
end
