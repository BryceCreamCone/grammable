require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "#index" do
    it "successfully shows the webpage" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "#new" do
    it "successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    it "successfully stores a new gram to the database" do
      post :create, params: { gram: { message: "Hello!" } }
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq("Hello!")
    end
  end
end
