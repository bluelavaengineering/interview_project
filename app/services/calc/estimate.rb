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
          diff >=1 ? bottom + diff.floor : bottom
        else
          @year = 1990
          top
        end
      end
  end
end
