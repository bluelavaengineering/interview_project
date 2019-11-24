module PopulationLookup
  class BaseService

    def self.lookup_by_year(year)
      year = year.to_i

      # Case 1: Query is for a year that comes before those we have data for
      earliest_year = Population.minimum(:year).year
      return 0 if year < earliest_year

      # Case 2: Query is for a year that is after those we have data for
      latest_year = Population.maximum(:year).year
      return ::PopulationLookup::ExponentialExtrapolationService.new(year).call if year > latest_year

      # Case 3: Query is for a year we have data for
      known_pop = Population.find_by_year(Date.new(year))
      return known_pop.population if known_pop.present?

      # Case 4: Query is for a year we don't have data for, but can linearly interpolate for
      raise "illegal state" if year < earliest_year || year > latest_year
      return ::PopulationLookup::LinearInterpolationService.new(year).call
    end

  end
end
