class Population < ApplicationRecord
  has_many :population_inquiry_log_items, foreign_key: 'request_valid_year', primary_key: 'year_number'

  validates :year_number, presence: true
end
