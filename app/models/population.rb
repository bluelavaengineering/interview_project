class Population < ApplicationRecord

  def self.at_year(year)
    ::PopulationLookup::BaseService.lookup_by_year(year)
  end

end
