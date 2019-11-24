class PopulationsController < ApplicationController
  helper_method :year, :population
  
  def index
  end

  def show
    @year = params[:year]
    @population = Population.at_year(@year)
  end

  private

  def year
    @year
  end

  def population
    @population
  end
end
