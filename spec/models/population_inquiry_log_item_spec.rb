require 'rails_helper'

RSpec.describe PopulationInquiryLogItem, type: :model do
  # This code challenge is starting to run long, so I will tell you what I would have tested here:
  # * Presence validations, including those that are conditional (e.g. request_valid_year)
  # * Edge cases for request_year_raw (nil, blank, non-int, int)
  # * Status values for response_status being checked (bonus: convert it to a postgres/your-db-here enum and have DB enforce consistency)
  # * #success? and #failed? working correctly true/false cases
end
