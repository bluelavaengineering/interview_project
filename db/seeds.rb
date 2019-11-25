# https://www.census.gov/population/www/censusdata/files/urpop0090.txt
Population.create(year_number: 1900, population: 76_212_168)
Population.create(year_number: 1910, population: 92_228_496)
Population.create(year_number: 1920, population: 106_021_537)
Population.create(year_number: 1930, population: 123_202_624)
Population.create(year_number: 1940, population: 132_164_569)
Population.create(year_number: 1950, population: 151_325_798)
Population.create(year_number: 1960, population: 179_323_175)
Population.create(year_number: 1970, population: 203_302_031)
Population.create(year_number: 1980, population: 226_542_199)
Population.create(year_number: 1990, population: 248_709_873)

# REFACTOR: FactoryBot would be more appropriate here, so that this object is created in the relevant test. You
# can break out different items by success/failed as factory traits.
PopulationInquiryLogItem.create!(
  request_year_raw: 1800,
  request_valid_year: 1800,
  response_status: PopulationInquiryLogItem::RESPONSE_STATUS_SUCCESS,
  response_population: 31337, # magic value for use in tests
  calculation_type: PopulationLookup::Response::RESPONSE_TYPE_EXACT
)
