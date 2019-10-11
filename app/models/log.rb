class Log < ApplicationRecord

  validates :year, :population, presence: true
end
