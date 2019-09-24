require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "#index" do
    it "successfully show the webpage" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
