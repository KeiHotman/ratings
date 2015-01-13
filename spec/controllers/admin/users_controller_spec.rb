require 'rails_helper'

RSpec.describe Admin::UsersController, :type => :controller do

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all users as @users" do
      user = FactoryGirl.create(:user)
      get :index, {}, valid_session
      expect(assigns(:users)).to eq([user])
    end
  end

  describe "GET show" do
    it "assigns the requested admin_user as @admin_user" do
      user = FactoryGirl.create(:user)
      get :show, {id: user.id}, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET new" do
    it "assigns a new admin_user as @admin_user" do
      get :new, {}, valid_session
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET edit" do
    it "assigns the requested admin_user as @admin_user" do
      user = FactoryGirl.create(:user)
      get :edit, {id: user.id}, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {user: FactoryGirl.attributes_for(:user)}, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created admin_user as @admin_user" do
        post :create, {user: FactoryGirl.attributes_for(:user)}, valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the created admin_user" do
        post :create, {user: FactoryGirl.attributes_for(:user)}, valid_session
        expect(response).to redirect_to(admin_user_path(User.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved admin_user as @admin_user" do
        post :create, {user: FactoryGirl.attributes_for(:invalid_user)}, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, {user: FactoryGirl.attributes_for(:invalid_user)}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) { FactoryGirl.attributes_for(:user, name: 'new name') }

      it "updates the requested admin_user" do
        user = FactoryGirl.create(:user)
        put :update, {id: user.id, user: new_attributes}, valid_session
        user.reload
        expect(user.name).to eq 'new name'
      end

      it "assigns the requested admin_user as @admin_user" do
        user = FactoryGirl.create(:user)
        put :update, {id: user.id, user: FactoryGirl.attributes_for(:user)}, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "redirects to the admin_user" do
        user = FactoryGirl.create(:user)
        put :update, {id: user.id, user: FactoryGirl.attributes_for(:user)}, valid_session
        expect(response).to redirect_to(admin_user_path(user))
      end
    end

    describe "with invalid params" do
      it "assigns the admin_user as @admin_user" do
        user = FactoryGirl.create(:user)
        put :update, {id: user.id, user: FactoryGirl.attributes_for(:invalid_user)}, valid_session
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        user = FactoryGirl.create(:user)
        put :update, {id: user.id, user: FactoryGirl.attributes_for(:invalid_user)}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested admin_user" do
      user = FactoryGirl.create(:user)
      expect {
        delete :destroy, {id: user.id}, valid_session
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = FactoryGirl.create(:user)
      delete :destroy, {id: user.id}, valid_session
      expect(response).to redirect_to(admin_users_url)
    end
  end

end
