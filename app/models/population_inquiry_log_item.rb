# REFACTOR: The database is not the best place to dump logs, though it works in a pinch!
class PopulationInquiryLogItem < ApplicationRecord
  # request_valid_year may be absent if it is not valid (e.g. error)
  # response_population may be absent if there was no population resolved (e.g. error)

  RESPONSE_STATUS_SUCCESS = "success".freeze
  RESPONSE_STATUS_FAILED = "failed".freeze

  # Track raw input - what if someone is trying to input decimal notation or something crazy?
  validates :request_year_raw, presence: true, allow_blank: true

  validates :response_status, presence: true, inclusion: {in: [ RESPONSE_STATUS_SUCCESS, RESPONSE_STATUS_FAILED ]}
  validates :calculation_type, presence: true, inclusion: {in: [
      ::PopulationLookup::Response::RESPONSE_TYPE_CALCULATED,
      ::PopulationLookup::Response::RESPONSE_TYPE_EXACT ]
    }, if: -> { calculation_type.present? }

  # If the response was a success, it must follow that we captured a valid year & returned population
  validates :request_valid_year, presence: true, if: :success?
  validates :response_population, presence: true, if: :success?
  validates :calculation_type, presence: true, if: :success?

  def success?
    response_status == RESPONSE_STATUS_SUCCESS
  end

  def failed?
    response_status == RESPONSE_STATUS_FAILED
  end
end
