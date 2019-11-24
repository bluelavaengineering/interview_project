class PopulationsController < ApplicationController
  def index
  end

  def show
    @year = params[:year].html_safe
    @population = Population.population_at_or_before_year(@year)
  end
end
