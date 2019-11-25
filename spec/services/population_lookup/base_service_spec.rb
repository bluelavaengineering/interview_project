require 'rails_helper'

RSpec.describe PopulationLookup::BaseService, type: :unit do

  describe "#population of result" do

    it "should accept a year we know and return the correct population" do
      expect(get_pop(1900)).to eq(76212168)
      expect(get_pop(1990)).to eq(248709873)
    end

    it "should accept a year that is before earliest known and return zero" do
      expect(get_pop(1800)).to eq(0)
      expect(get_pop(0)).to eq(0)
      expect(get_pop(-1000)).to eq(0)
    end

    it "linearly extrapolates population for years inside of our known range" do
      expect(get_pop(1955)).to eq(165324487)
      expect(get_pop(1902)).to eq(79415434)
      expect(get_pop(1908)).to eq(89025230)
    end

    it "extrapolates population by exponential growth for years in which data is missing" do
      expect(get_pop(1991)).to eq(271093762)
      expect(get_pop(2099)).to eq(2986629161671)
    end

  end

  describe "#response_type" do

    it "will be calculated when picking an early year" do
      expect(get_response(0).response_type).to eq('calculated')
    end

    it "will be calculated when picking a year beyond those available" do
      expect(get_response(2400).response_type).to eq('calculated')
    end

    it "will be calculated when picking a year we interpolate for" do
      expect(get_response(1955).response_type).to eq('calculated')
    end

    it "will be exact when picking a year we have data for" do
      expect(get_response(1900).response_type).to eq('exact')
    end

  end

  def get_response(year)
    ::PopulationLookup::BaseService.lookup_by_year(year)
  end

  def get_pop(year)
    get_response(year).population
  end

end
