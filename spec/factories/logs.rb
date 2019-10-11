FactoryBot.define do
  factory :log do
    year { rand(1900..2500) }
    population { rand(90000000..750000000) }
    request_type { rand(0..1) }
  end
end
