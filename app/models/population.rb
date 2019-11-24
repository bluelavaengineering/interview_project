class Population < ApplicationRecord

  def self.smallest_known_year
    Population.minimum(:year).year
  end

  def self.population_at_or_before_year(year)
    year = year.to_i
    return 0 if year < smallest_known_year

    pop = Population
            .where('year <= :year', year: Date.new(year))
            .order(:year)
            .last

    raise "illegal state: impossible that #{year} does not have pop result" if pop.nil?

    return pop.population
  end

end
