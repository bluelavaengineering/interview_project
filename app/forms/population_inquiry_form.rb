class PopulationInquiryForm < ApplicationForm
  attr_accessor :year_number

  validates :year_number, presence: true
  validates :year_number, numericality: { only_integer: true, less_than_or_equal_to: 2500 }
end
