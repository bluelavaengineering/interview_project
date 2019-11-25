class ChangePopulationOnPopulationInquiryLogItem < ActiveRecord::Migration[5.2]
  def change
    # Some derived populations are too large to store as sqlite integers
    change_column :population_inquiry_log_items, :response_population, :string
  end
end
