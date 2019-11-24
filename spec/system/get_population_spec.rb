require 'rails_helper'

RSpec.describe "Get population by year", type: :system do
  it "User is presented with an input form" do
    visit populations_path
    assert_selector "input[name=year]"
    assert_selector "button[type=submit]"
  end

  describe "When user enters a valid year and then submits" do
    before(:each) do
      visit populations_path
      fill_in "year", with: "1960"
      click_button("Submit")
    end

    it "redirects to a results page" do
      assert_current_path "/populations/by_year?year=1960"
    end

    it "shows a population figure" do
      assert_text "Population: 179323175"
    end
  end
end
