require 'rails_helper'

RSpec.describe PopulationInquiryForm, type: :model do

  it "will not allow empty string" do
    p = build_form(year_number: '')
    expect(p.valid?).to eq(false)
    expect(p.errors[:year_number]).to match_array(["can't be blank", "is not a number"])
  end

  it "will not allow nil" do
    p = build_form(year_number: nil)
    expect(p.valid?).to eq(false)
    expect(p.errors[:year_number]).to match_array(["can't be blank", "is not a number"])
  end

  it "will allow negative numbers" do
    p = build_form(year_number: -500)
    expect(p.valid?).to eq(true)
  end

  it "will allow a very high number just prior to limit" do
    p = build_form(year_number: 2500)
    expect(p.valid?).to eq(true)
  end

  it "will not allow 2501" do
    p = build_form(year_number: 2501)
    expect(p.valid?).to eq(false)
    expect(p.errors[:year_number]).to match_array(["must be less than or equal to 2500"])
  end

  it "will not allow numbers higher than 2501" do
    p = build_form(year_number: 3000)
    expect(p.valid?).to eq(false)
    expect(p.errors[:year_number]).to match_array(["must be less than or equal to 2500"])
  end

  def build_form(attrs)
    PopulationInquiryForm.new(attrs.merge(growth_model: 'exponential'))
  end
end
