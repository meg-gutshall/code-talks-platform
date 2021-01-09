require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/ideas', type: :request do
  # Idea. As you add validations to Idea, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    attributes_for(:idea)
  end

  let(:invalid_attributes) do
    FactoryBot.attributes_for(:idea).transform_values { '' }
  end

  let(:user) do
    create(:user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create(:idea)
      get ideas_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      idea = create(:idea)
      get idea_url(idea)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    before { sign_in user }

    it 'renders a successful response' do
      get new_idea_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    before { sign_in user }

    it 'render a successful response' do
      idea = create(:idea, user: user)
      get edit_idea_url(idea)
      expect(response).to be_successful
    end

    context 'when idea is owned by another user' do
      it 'redirects to index' do
        idea = create(:idea)
        get edit_idea_url(idea)
        expect(response).to redirect_to(ideas_url)
      end
    end

    context 'with no user is signed in' do
      before { sign_out user }

      it 'redirects to user login' do
        idea = create(:idea)
        get edit_idea_url(idea)
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'POST /create' do
    before { sign_in user }

    context 'with valid parameters' do
      it 'creates a new Idea' do
        expect do
          post ideas_url, params: { idea: valid_attributes }
        end.to change(Idea, :count).by(1)
      end

      it 'redirects to the created idea' do
        post ideas_url, params: { idea: valid_attributes }
        expect(response).to redirect_to(idea_url(Idea.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Idea' do
        expect do
          post ideas_url, params: { idea: invalid_attributes }
        end.to change(Idea, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post ideas_url, params: { idea: invalid_attributes }
        expect(response).to be_successful
      end
    end

    context 'with no user is signed in' do
      before do
        sign_out user
      end

      it 'redirects to login without creating idea' do
        expect do
          post ideas_url, params: { idea: invalid_attributes }
        end.to change(Idea, :count).by(0)

        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'PATCH /update' do
    before { sign_in user }

    context 'with valid parameters' do
      let(:new_attributes) do
        FactoryBot.attributes_for(:idea).transform_values { 'new-value' }
      end

      it 'updates the requested idea' do
        idea = create(:idea, user: user)
        patch idea_url(idea), params: { idea: new_attributes }
        idea.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the idea' do
        idea = create(:idea, user: user)
        patch idea_url(idea), params: { idea: new_attributes }
        idea.reload
        expect(response).to redirect_to(idea_url(idea))
      end

      context 'when idea is owned by another user' do
        it 'redirects to index without making a change' do
          idea = create(:idea)
          expect do
            patch idea_url(idea), params: { idea: new_attributes }
          end.not_to change(Idea, :count)

          expect(response).to redirect_to(ideas_url)
        end
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        idea = create(:idea, user: user)
        patch idea_url(idea), params: { idea: invalid_attributes }
        expect(response).to be_successful
      end
    end

    context 'with no user is signed in' do
      before { sign_out User.last }

      it 'redirects to login' do
        idea = create(:idea, user: user)
        patch idea_url(idea), params: { idea: invalid_attributes }

        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'DELETE /destroy' do
    before { sign_in user }

    it 'destroys the requested idea' do
      idea = create(:idea, user: user)
      expect do
        delete idea_url(idea)
      end.to change(Idea, :count).by(-1)
    end

    it 'redirects to the ideas list' do
      idea = create(:idea, user: user)
      delete idea_url(idea)
      expect(response).to redirect_to(ideas_url)
    end

    context 'when idea is owned by another user' do
      it 'does not change idea count' do
        idea = create(:idea)
        expect do
          delete idea_url(idea)
        end.to change(Idea, :count).by(0)
        expect(response).to redirect_to(ideas_url)
      end
    end

    context 'with no user is signed in' do
      before { sign_out user }

      it 'redirects to login' do
        idea = create(:idea, user: user)
        delete idea_url(idea)

        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end
