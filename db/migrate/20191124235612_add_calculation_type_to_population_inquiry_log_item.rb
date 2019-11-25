class AddCalculationTypeToPopulationInquiryLogItem < ActiveRecord::Migration[5.2]
  def change
    add_column :population_inquiry_log_items, :calculation_type, :string
  end
end
