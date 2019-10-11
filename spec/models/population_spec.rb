require 'rails_helper'

RSpec.describe Population, type: :model do

  it "should accept a year we know and return the correct population" do
    expect(Population.get(1900)).to eq(76212168)
    expect(Population.get(1990)).to eq(248709873)
  end

  it "should accept a year we don't know and return estimated population" do
    expect(Population.get(1902)).not_to eq(76212168)
    expect(Population.get(1908)).not_to eq(76212168)
  end

  it "should accept a year that is before earliest known and return zero" do
    expect(Population.get(1800)).to eq(0)
    expect(Population.get(0)).to eq(0)
    expect(Population.get(-1000)).to eq(0)
  end

  it "should accept a year that is after latest known and return forcasted population" do
    expect(Population.get(2000)).to eq(272022412)
    expect(Population.get(2050)).to eq(425758179)
  end

end
