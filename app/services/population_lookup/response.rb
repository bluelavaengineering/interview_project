module PopulationLookup
  class Response
    attr_reader :response_type
    attr_reader :population

    RESPONSE_TYPE_CALCULATED = 'calculated'
    RESPONSE_TYPE_EXACT = 'exact'

    VALID_RESPONSE_TYPES = [ RESPONSE_TYPE_CALCULATED, RESPONSE_TYPE_EXACT ]

    def initialize(response_type, population)
      @response_type = response_type
      @population = population

      raise ArgumentError, "response_type must be in #{VALID_RESPONSE_TYPES}" unless VALID_RESPONSE_TYPES.include?(response_type)
      raise ArgumentError, "population must be present" unless population.present?
    end
  end
end
