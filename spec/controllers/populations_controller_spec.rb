require 'rails_helper'

RSpec.describe PopulationsController, type: :controller do
  render_views

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "rejects an invalid input" do
      get :show, format: :js, xhr: true, params: { population_inquiry_form: { year_number: "" } }
      expect(response).to have_http_status(:success) # "success" semantics OK since this is just a UI update
      expect(response.body).to match /Please re-submit your query/im
    end

    it "returns http success" do
      get :show, format: :js, xhr: true, params: { population_inquiry_form: { year_number: "1900" } }
      expect(response).to have_http_status(:success)
    end

    it "returns a population for a date" do
      get :show, format: :js, xhr: true, params: { population_inquiry_form: { year_number: "1900" } }
      expect(response.content_type).to eq "text/javascript"
      expect(response.body).to match /Population: #{76212168}/im
    end
  end
end
