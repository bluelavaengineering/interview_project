class PopulationsController < ApplicationController
  def index
  end

  def show
    @year = params[:year].html_escape
    @population = Population.get(@year)
  end
end
