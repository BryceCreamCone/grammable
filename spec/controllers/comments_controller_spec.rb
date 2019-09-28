require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "#create" do
    it "allows users to create comments on a gram" do
      gram = FactoryBot.create(:gram)

      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: {
        gram_id: gram.id,
        comment: {
          comment: 'Awesome Gram'
        }
      }
      expect(response).to redirect_to root_path
      expect(gram.comments.first.comment).to eq "Awesome Gram"
    end

    it "requires a user to be logged in to comment on a gram" do
      gram = FactoryBot.create(:gram)

      post :create, params: { 
        gram_id: gram.id,
        comment: {
          comment: 'Awesome Gram'
        } 
      }
      expect(response).to redirect_to new_user_session_path
      expect(gram.comments.length).to eq 0
    end

    it "returns 404 status not found if gram isn't found" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: {
        gram_id: 'NONEXISTENT',
        comment: {
          comment: 'Awesome Gram'
        }
      }
      expect(response).to have_http_status(:not_found)
    end
  end


end
