class PopulationsController < ApplicationController
  attr_reader :population, :furthest_year
  helper_method :population, :population_inquiry_form, :furthest_year

  def index
    @furthest_year = Population.maximum(:year_number)
  end

  def show
    if population_inquiry_form.valid?
      result = ::PopulationLookup::BaseService.lookup_by_year(
        population_inquiry_form.year_number,
        population_inquiry_form.growth_model.to_sym)
      @population = result.population
      log_successful_reply(result)
    else
      log_failed_reply
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def log_successful_reply(population_lookup_result)
    raise "illegal state" if population.nil?
    PopulationInquiryLogItem.create!(
      request_year_raw: population_inquiry_form.year_number,
      request_valid_year: population_inquiry_form.year_number,
      response_status: PopulationInquiryLogItem::RESPONSE_STATUS_SUCCESS,
      response_population: population,
      calculation_type: population_lookup_result.response_type
    )
  end

  def log_failed_reply
    PopulationInquiryLogItem.create!(
      request_year_raw: population_inquiry_form.year_number,
      request_valid_year: nil,
      response_status: PopulationInquiryLogItem::RESPONSE_STATUS_FAILED,
      response_population: nil,
      calculation_type: nil
    )
  end

  def population_inquiry_form
    PopulationInquiryForm.new(population_inquiry_form_params)
  end

  def population_inquiry_form_params
    params[:population_inquiry_form].permit(:year_number, :growth_model)
  end
end
