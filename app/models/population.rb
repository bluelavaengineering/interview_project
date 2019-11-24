class Population < ApplicationRecord
  EXPONENTIAL_GROWTH_RATE = 0.09

  def self.smallest_known_year
    Population.minimum(:year).year
  end

  # REFACTOR: This model is getting heavy, and this looks like a service/strategy-pattern
  def self.at_year(year)
    year = year.to_i
    return 0 if year < smallest_known_year

    # Try to return known population
    known_pop = Population.find_by_year(Date.new(year))

    return known_pop.population if known_pop.present?

    population_in_known_range = year <= Population.maximum(:year).year

    return linearly_extrapolate_population_at_year(year) if population_in_known_range

    return exponentially_extrapolate_population_at_year(year)
  end

  private

  # Given a year that does not exist in our data set, this linearly extrapolates
  # its population.
  def self.linearly_extrapolate_population_at_year(year)
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

  # Models exponential growth per https://en.wikipedia.org/wiki/Exponential_growth
  #
  # Formula:
  #   x_t = x_0 * (1 + r) ^ t
  #
  # Where:
  #   x_t - Population at time t
  #   x_0 - Population at initial time t=0
  #   r - EXPONENTIAL_GROWTH_RATE
  #   t - Time; for our purpose here, years elapsed since x_0 was determined
  #
  # Wolfram Example:
  #   Given that the population is 248709873 in 1990, derive future populations according to a variable t
  #   representing number of years after 1990.
  #   https://www.wolframalpha.com/input/?i=248709873+*+%28%281%2B0.09%29%5E%28t%29%29
  def self.exponentially_extrapolate_population_at_year(year)
    latest_known_pop = Population.order(:year).last

    x_0 = latest_known_pop.population
    r = EXPONENTIAL_GROWTH_RATE
    t = year - latest_known_pop.year.year
    x_t = x_0 * ((1 + r) ** t)

    return x_t.round
  end

end
