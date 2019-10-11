module Service
  # This class needs some serious exception handling, skipping for time
  class Calc::Estimate
    include Common::Service
    attr_reader :year

    def initialize(year)
      @year = year
    end

    def call
      # really does not need the casting but, double sure
      adjust.to_i
    end

    private
      # THese two methods would need DRYing up, zero reason to do two queries
      def bottom
        pop = Population.where("year <= ?", Date.new(@year)).order(year: :desc).limit(1).first
        pop.population if pop
      end

      def top
        pop = Population.where("year >= ?", Date.new(@year)).order(year: :asc).limit(1).first
        pop.population if pop
      end

      def guess_by
        first = @year.to_i % 10
        first.to_f / 10
      end

      def adjust
        # This needs a refactor to get rid of the hard coded years
        if year <= 1990
          diff = (top.to_f * guess_by).to_i
          pop = diff >=1 ? bottom + diff.floor : bottom
          log(request_type: diff >= 1 ? :calculated : :exact, year: year, population: pop)
        elsif year >= 1991
          requested_year = year
          @year = 1990
          pop = forcast(inital_population: top, target: requested_year)
          log(request_type: :calculated, year: requested_year, population: pop)
        end
        return pop
      end

      def forcast(inital_population:, rate: 0.009, target: 2020)
        target = target > 2500 ? 2500 : target
        interval = target - 1990
        f = BigDecimal(inital_population)*(1+rate)**interval
        f.to_i
      end

      def log(**options)
        Logging::Record.call(request_type: options.request_type, year: options.year, population: options.population )
      end

  end
end
