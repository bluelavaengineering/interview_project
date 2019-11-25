require 'rails_helper'

RSpec.describe PopulationInquiryLogItemsController, type: :controller do
  render_views

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns a log item" do
      magic_log_item = PopulationInquiryLogItem.find_by!(response_population: 31337, request_year_raw: 1800)

      get :index

      expect(response.body).to include(magic_log_item.response_population.to_s)
      expect(response.body).to include(magic_log_item.request_year_raw.to_s)
    end
  end
end
