require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "#index" do
    it "successfully shows the webpage" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "#show" do
    it "successfully shows the user the page if the gram is found" do
      gram = FactoryBot.create(:gram)
      get :show, params: { id: gram.id }
      expect(response).to have_http_status(:success)
    end

    it "returns a 404 error if the gram is not found" do
      get :show, params: { id: 'NONEXISTENT' }
      expect(response).to have_http_status(:not_found)
    end
  end


  describe "#new" do
    it "successfully show the new form" do
      user = FactoryBot.create(:user)
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end

    it "should require the user to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  end


  describe "#create" do
    it "should require the user to be logged in" do
      post :create, params: { gram: { message: "Hello!" } }
      expect(response).to redirect_to new_user_session_path
    end

    it "successfully stores a new gram to the database" do
      user = FactoryBot.create(:user)
      sign_in user
      post :create, params: { 
        gram: { 
          message: "Hello!",
          image: fixture_file_upload("/image.png", "image/png")
          }
        }
      expect(response).to redirect_to root_path

      gram = Gram.last
      expect(gram.message).to eq("Hello!")
      expect(gram.user).to eq(user)
    end

    it "correctly deals with validation errors" do
      user = FactoryBot.create(:user)
      sign_in user
      gram_count = Gram.count
      post :create, params: { gram: { message: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(gram_count).to eq Gram.count
    end
  end


  describe "#edit" do
    it "should only allow the owner of the gram to edit it" do
      gram  = FactoryBot.create(:gram, message: "gram_owner - No Edit" )
      not_gram_owner = FactoryBot.create(:user)
      sign_in not_gram_owner
      get :edit, params: { id: gram.id, gram: { message: "not_gram_owner was allowed to edit" } }
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't allow unauthenticated users to edit a gram" do
      gram = FactoryBot.create(:gram)
      get :edit, params: { id: gram.id, gram: { message: "Hello!" } }
      expect(response).to redirect_to new_user_session_path
    end

    it "shows the edit form if a gram is found" do
      gram = FactoryBot.create(:gram)
      sign_in gram.user
      get :edit, params: { id: gram.id }
      expect(response).to have_http_status(:success)
    end

    it "returns a 404 error message if a gram is not found" do
      user = FactoryBot.create(:user)
      sign_in user
      get :edit, params: { id: 'NONEXISTENT' }
      expect(response).to have_http_status(:not_found)
    end
  end

  
  describe "#update" do
    it "should only allow the owner of the gram to update it" do
      gram  = FactoryBot.create(:gram, message: "gram_owner - No Update" )
      not_gram_owner = FactoryBot.create(:user)
      sign_in not_gram_owner
      patch :update, params: { id: gram.id, gram: { message: "not_gram_owner was allowed to update" } }
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't allow unauthenticated users to update a gram" do
      gram = FactoryBot.create(:gram)
      patch :update, params: { id: gram.id, gram: { message: "Updated!" } }
      expect(response).to redirect_to new_user_session_path
    end

    it "allows a user to update a gram" do
      gram = FactoryBot.create(:gram, message: "Not Updated Yet!")
      sign_in gram.user
      patch :update, params: { id: gram.id, gram: { message: "Updated!" } }
      expect(response).to redirect_to root_path
      gram.reload
      expect(gram.message).to eq("Updated!")
    end

    it "returns a 404 error message if a gram is not found" do
      user = FactoryBot.create(:user)
      sign_in user
      patch :update, params: { id: 'NONEXISTENT', gram: { message: "Updated!" } }
      expect(response).to have_http_status(:not_found)
    end

    it "displays the edit page again if there were any validation errors" do
      gram = FactoryBot.create(:gram, message: "Not Updated Yet!")
      sign_in gram.user
      patch :update, params: { id: gram.id, gram: { message: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
      gram.reload
      expect(gram.message).to eq("Not Updated Yet!")
    end
  end


  describe "#destroy" do
    it "should only allow the owner of the gram to destroy it" do
      gram  = FactoryBot.create(:gram)
      not_gram_owner = FactoryBot.create(:user)
      sign_in not_gram_owner
      delete :destroy, params: { id: gram.id }
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't allow unauthenticated users to destroy a gram" do
      gram = FactoryBot.create(:gram)
      delete :destroy, params: { id: gram.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "allows a user to destroy a gram" do
      gram = FactoryBot.create(:gram, message: "Not Deleted.")
      sign_in gram.user
      delete :destroy, params: { id: gram.id }
      expect(response).to redirect_to root_path
      gram = Gram.find_by_id(gram.id)
      expect(gram).to eq nil
    end

    it "returns a 404 error message if a gram is not found" do
      user = FactoryBot.create(:user)
      sign_in user
      delete :destroy, params: { id: 'NONEXISTENT' }
      expect(response).to have_http_status(:not_found)
    end
  end
end