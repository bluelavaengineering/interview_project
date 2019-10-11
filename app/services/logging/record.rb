module Service
  class Logging::Record
    include Common::Service
    attr_reader :year, :population, :request_type

    def initialize
      @year = year
      @population = population
      @request_type = request_type
    end

    def call
      create_entry(request_type: @request_type, year: @year, population: @population)
    end

    private
      def create_entry(request_type:, year:, population:)
        begin
          Log.transaction do
            Log.create!(request_type, year, population)
            raise ActiveRecord::Rollback
          end
        rescue ActiveRecord::RecordInvalid => invalid
          # Hah! logging in a logger
          Rails.logger.error "Failed to insert into Logs. year: #{year} population: #{population} Message: #{invalid.Message}"
        end
      end
  end
end
