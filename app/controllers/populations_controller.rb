class PopulationsController < ApplicationController
  attr_reader :population
  helper_method :population, :population_inquiry_form

  def index
  end

  def show
    if population_inquiry_form.valid?
      @population = Population.at_year(population_inquiry_form.year_number)
      log_successful_reply
    else
      log_failed_reply
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def log_successful_reply
    raise "illegal state" if population.nil?
    PopulationInquiryLogItem.create!(
      request_year_raw: population_inquiry_form.year_number,
      request_valid_year: population_inquiry_form.year_number,
      response_status: PopulationInquiryLogItem::RESPONSE_STATUS_SUCCESS,
      response_population: population,
    )
  end

  def log_failed_reply
    PopulationInquiryLogItem.create!(
      request_year_raw: population_inquiry_form.year_number,
      request_valid_year: nil,
      response_status: PopulationInquiryLogItem::RESPONSE_STATUS_FAILED,
      response_population: nil,
    )
  end

  def population_inquiry_form
    PopulationInquiryForm.new(population_inquiry_form_params)
  end

  def population_inquiry_form_params
    params[:population_inquiry_form].permit(:year_number)
  end
end
