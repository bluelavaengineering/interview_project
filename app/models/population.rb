class Population < ApplicationRecord

  def self.smallest_known_year
    Population.minimum(:year).year
  end

  def self.at_year(year)
    year = year.to_i
    return 0 if year < smallest_known_year

    # Try to return known population
    known_pop = Population.find_by_year(Date.new(year))

    return known_pop.population if known_pop.present?

    # ... But otherwise, interpolate
    return extrapolate_population_at_year(year)
  end

  private

  # Given a year that does not exist in our data set, this linearly extrapolates
  # its population.
  def self.extrapolate_population_at_year(year)
    prior_pop = Population
                  .where('year < :year', year: Date.new(year))
                  .order(:year)
                  .last
    later_pop = Population
                  .where('year > :year', year: Date.new(year))
                  .order(:year)
                  .first

    return prior_pop.population if later_pop.nil? # i.e. we have nothing in future to extrapolate from

    span_length_in_years = later_pop.year.year - prior_pop.year.year
    pop_difference_in_span = later_pop.population - prior_pop.population

    years_into_span = year - prior_pop.year.year
    scale_factor = (years_into_span.to_f / span_length_in_years.to_f)

    extrapolated_population = prior_pop.population + (scale_factor * pop_difference_in_span)

    return extrapolated_population.round
  end

end
