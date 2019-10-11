class PopulationsController < ApplicationController
  def index
  end

  def show
    @year = params[:year].html_escape
    @population = Population.get(@year)
    respond_to do |format|
      format.js { render :results }
      format.html { render :show }
    end
  end
end
