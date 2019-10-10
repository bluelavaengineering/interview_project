class Population < ApplicationRecord

  def self.min_year
    Population.all.map(&:year).min.year
  end

  def self.get(year)
    year = year.to_i
    return 0 if year < min_year
    pop = Population.where("year <= ?", Date.new(year)).order(year: :desc).limit(1).first
    pop.population if pop
  end

end
