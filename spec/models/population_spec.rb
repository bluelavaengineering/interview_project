require 'rails_helper'

RSpec.describe Population, type: :model do

  it "should accept a year we know and return the correct population" do
    expect(Population.at_year(1900)).to eq(76212168)
    expect(Population.at_year(1990)).to eq(248709873)
  end

  it "should accept a year that is before earliest known and return zero" do
    expect(Population.at_year(1800)).to eq(0)
    expect(Population.at_year(0)).to eq(0)
    expect(Population.at_year(-1000)).to eq(0)
  end

  it "linearly extrapolates population for years inside of our known range" do
    expect(Population.at_year(1955)).to eq(165324487)
    expect(Population.at_year(1902)).to eq(79415434)
    expect(Population.at_year(1908)).to eq(89025230)
  end

  it "extrapolates population by exponential growth for years in which data is missing" do
    expect(Population.at_year(1991)).to eq(271093762)
    expect(Population.at_year(2099)).to eq(2986629161671)
  end

end
