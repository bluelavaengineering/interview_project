class PopulationsController < ApplicationController
  attr_reader :population, :population_inquiry_form
  helper_method :population, :population_inquiry_form

  def index
  end

  def show
    @population_inquiry_form = PopulationInquiryForm.new(population_inquiry_form_params)
    if @population_inquiry_form.valid?
      @population = Population.at_year(@population_inquiry_form.year_number)
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def population_inquiry_form_params
    params[:population_inquiry_form].permit(:year_number)
  end
end
