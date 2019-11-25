module PopulationLookup
  class LinearInterpolationService
    attr_reader :year

    def initialize(year)
      @year = year
    end

    # Given that we have population metrics for at least one year coming before this one, and one year
    # coming after this one, we can linearly interpolate to arrive at an estimated population.
    def call
      how_many_years_since_prior_year = year - prior_pop.year_number
      how_far_we_are_since_first_year_as_percent = (how_many_years_since_prior_year.to_f / elapsed_years_between.to_f)

      extrapolated_population = prior_pop.population + (how_far_we_are_since_first_year_as_percent * population_difference_between)

      return extrapolated_population.round
    end

    def elapsed_years_between
      later_pop.year_number - prior_pop.year_number
    end

    def population_difference_between
      later_pop.population - prior_pop.population
    end

    def prior_pop
      @_prior_pop || Population
        .where('year_number < :year', year: year)
        .order(:year_number)
        .last
    end

    def later_pop
      @_later_pop || Population
        .where('year_number > :year', year: year)
        .order(:year_number)
        .first
    end
  end
end
