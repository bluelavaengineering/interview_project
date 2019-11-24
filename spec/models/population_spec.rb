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

  it "should accept a year that is after latest known and return the last known population" do
    expect(Population.at_year(2000)).to eq(248709873)
    expect(Population.at_year(200000)).to eq(248709873)
  end

  it "linearly extrapolate population for years in which data is missing" do
    expect(Population.at_year(1955)).to eq(165324487)
    expect(Population.at_year(1902)).to eq(79415434)
    expect(Population.at_year(1908)).to eq(89025230)
  end


end
