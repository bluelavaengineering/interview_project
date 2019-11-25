require 'rails_helper'

RSpec.describe "Get population by year", type: :system, js: true do

  it "User is presented with an input form" do
    visit populations_path
    assert_selector 'input[name=population_inquiry_form\[year_number\]]'
    assert_selector "input[type=submit]"
  end

  describe "When user enters a valid year and then submits" do
    before(:each) do
      visit populations_path
      fill_in "population_inquiry_form[year_number]", with: "1960"
      click_button("Submit")
    end

    it "shows a population figure and remains on same page" do
      assert_text "Population: 179323175"
      assert_current_path populations_path # this MUST be evaluated AFTER confirming results returned, or you could produce a false-pass (i.e. eval too early)
    end
  end

  # REFACTOR: Why not find or build a library to auto-generate plausible XSS strings containing common
  # JS you want to try to execute? There are surely more.
  # I'm sure metasploit or similar tools have a good reference implementation :)
  EVIL_INPUTS = ['<script>window._canary_state=true</script>', ';window._canary_state=true;']

  describe "Security" do
    EVIL_INPUTS.each do |evil_input|
      describe "When evil party asks user to provide input '#{evil_input}'" do
        before(:each) do
          visit populations_path
          fill_in "population_inquiry_form[year_number]", with: evil_input
          click_button("Submit")
        end

        it "should not have compromised front-end and should be rejected with a validation error" do
          assert_text "Year number is not a number"

          canary_state = page.evaluate_script('window._canary_state')
          expect(canary_state).to be_nil
        end
      end
    end
  end
end
