module Service
  class Logging::Record
    include Common::Service
    attr_reader :request_type, :year, :population

    def initialize(request_type, year, population)
      @request_type = request_type
      @year = year
      @population = population
    end

    def call
      create_entry(@request_type, @year, @population)
    end

    private
      def create_entry(request_type, year, population)
        Log.create!(request_type: request_type, year: year, population: population)
      end
  end
end
