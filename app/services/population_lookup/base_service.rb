module PopulationLookup
  class BaseService

    def self.lookup_by_year(year)
      year = year.to_i

      # Case 1: Query is for a year that comes before those we have data for
      earliest_year = Population.minimum(:year_number)
      return Response.new(Response::RESPONSE_TYPE_CALCULATED, 0) if year < earliest_year

      # Case 2: Query is for a year that is after those we have data for
      latest_year = Population.maximum(:year_number)
      if year > latest_year
        return Response.new(
          Response::RESPONSE_TYPE_CALCULATED,
          ExponentialExtrapolationService.new(year).call)
      end

      # Case 3: Query is for a year we have data for
      known_pop = Population.find_by_year_number(year)
      return Response.new(Response::RESPONSE_TYPE_EXACT, known_pop.population) if known_pop.present?

      # Case 4: Query is for a year we don't have data for, but can linearly interpolate for
      raise "illegal state" if year < earliest_year || year > latest_year

      return Response.new(
        Response::RESPONSE_TYPE_CALCULATED,
        LinearInterpolationService.new(year).call)
    end

  end
end
