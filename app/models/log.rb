class Log < ApplicationRecord

  enum request_type: [:exact, :calculated]

  validates :year, :population, :request_type, presence: true
end
