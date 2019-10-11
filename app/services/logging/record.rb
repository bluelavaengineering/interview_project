module Service
  class Logging::Record
    include Common::Service
    attr_reader :year, :population

    def initialize
      @year = year
      @population = population
    end

    def call
      create_entry(year: @year, population: @population)
    end

    private
      def create_entry(year:, population:)
        begin
          Log.transaction do
            Log.create!(year, population)
            raise ActiveRecord::Rollback
          end
        rescue ActiveRecord::RecordInvalid => invalid
          # Hah! logging in a logger
          Rails.logger.error "Failed to insert into Logs. year: #{year} population: #{population} Message: #{invalid.Message}"
        end
      end
  end
end
