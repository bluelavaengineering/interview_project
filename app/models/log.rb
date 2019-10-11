class Log < ApplicationRecord

  enum request_type: { exact: 0, calculated: 1 }

  validates :year, :population, :request_type, presence: true
end
