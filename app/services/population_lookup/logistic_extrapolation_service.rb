module PopulationLookup
  # Implementation of http://biorpy.blogspot.com/2015/03/py32-logistic-growth-in-python.html
  # When lost? Steal Python code! Lots of great data science reference work there.
  # (If this were a real PR, I'd flag that this is above my head, and I need more time to research - but
  # for the sake of time, I am going with this reference implementation, which does seem to cap out at 750MM
  # as expected)
  class LogisticExtrapolationService
    GROWTH_RATE = 0.09
    CARRYING_CAPACITY = 750_000_000

    attr_reader :year


    def initialize(year)
      @year = year
    end

    def call
      num_years = year - latest_known_pop.year_number

      num = [latest_known_pop.population]
      num_years.times { num << 0 }

      (0...num_years).each do |i|
        num[i+1] = num[i] + (GROWTH_RATE * num[i] * (1 - (num[i] / CARRYING_CAPACITY)))
      end

      return num.last.round
    end

    private

    def latest_known_pop
      @_latest_known_pop ||= Population.order(:year_number).last
    end
  end
end
