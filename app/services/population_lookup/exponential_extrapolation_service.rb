module PopulationLookup
  class ExponentialExtrapolationService
    EXPONENTIAL_GROWTH_RATE = 0.09

    attr_reader :year

    def initialize(year)
      @year = year
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
    def call
      x_0 = latest_known_pop.population
      r = EXPONENTIAL_GROWTH_RATE
      t = year - latest_known_pop.year_number
      x_t = x_0 * ((1 + r) ** t)

      return x_t.round
    end

    private

    def latest_known_pop
      @_latest_known_pop ||= Population.order(:year_number).last
    end
  end
end
