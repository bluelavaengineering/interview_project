class PopulationInquiryForm < ApplicationForm
  MAX_YEAR = 2500

  attr_accessor :year_number, :growth_model

  validates :year_number, presence: true
  validates :year_number, numericality: { only_integer: true, less_than_or_equal_to: MAX_YEAR }

  validates :growth_model, inclusion: { in: %w(logistic exponential) }

end
