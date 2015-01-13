require 'rails_helper'

RSpec.describe Admin::ItemsController, :type => :controller do

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all items as @items" do
      item = FactoryGirl.create(:item)
      get :index, {}, valid_session
      expect(assigns(:items)).to eq([item])
    end
  end

  describe "GET show" do
    it "assigns the requested admin_item as @admin_item" do
      item = FactoryGirl.create(:item)
      get :show, {id: item.id}, valid_session
      expect(assigns(:item)).to eq(item)
    end
  end

  describe "GET new" do
    it "assigns a new admin_item as @admin_item" do
      get :new, {}, valid_session
      expect(assigns(:item)).to be_a_new(Item)
    end
  end

  describe "GET edit" do
    it "assigns the requested admin_item as @admin_item" do
      item = FactoryGirl.create(:item)
      get :edit, {id: item.id}, valid_session
      expect(assigns(:item)).to eq(item)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Item" do
        expect {
          post :create, {item: FactoryGirl.attributes_for(:item)}, valid_session
        }.to change(Item, :count).by(1)
      end

      it "assigns a newly created admin_item as @admin_item" do
        post :create, {item: FactoryGirl.attributes_for(:item)}, valid_session
        expect(assigns(:item)).to be_a(Item)
        expect(assigns(:item)).to be_persisted
      end

      it "redirects to the created admin_item" do
        post :create, {item: FactoryGirl.attributes_for(:item)}, valid_session
        expect(response).to redirect_to(admin_item_path(Item.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved admin_item as @admin_item" do
        post :create, {item: FactoryGirl.attributes_for(:invalid_item)}, valid_session
        expect(assigns(:item)).to be_a_new(Item)
      end

      it "re-renders the 'new' template" do
        post :create, {item: FactoryGirl.attributes_for(:invalid_item)}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) { FactoryGirl.attributes_for(:item, name: 'new name') }

      it "updates the requested admin_item" do
        item = FactoryGirl.create(:item)
        put :update, {id: item.id, item: new_attributes}, valid_session
        item.reload
        expect(item.name).to eq 'new name'
      end

      it "assigns the requested admin_item as @admin_item" do
        item = FactoryGirl.create(:item)
        put :update, {id: item.id, item: FactoryGirl.attributes_for(:item)}, valid_session
        expect(assigns(:item)).to eq(item)
      end

      it "redirects to the admin_item" do
        item = FactoryGirl.create(:item)
        put :update, {id: item.id, item: FactoryGirl.attributes_for(:item)}, valid_session
        expect(response).to redirect_to(admin_item_path(item))
      end
    end

    describe "with invalid params" do
      it "assigns the admin_item as @admin_item" do
        item = FactoryGirl.create(:item)
        put :update, {id: item.id, item: FactoryGirl.attributes_for(:invalid_item)}, valid_session
        expect(assigns(:item)).to eq(item)
      end

      it "re-renders the 'edit' template" do
        item = FactoryGirl.create(:item)
        put :update, {id: item.id, item: FactoryGirl.attributes_for(:invalid_item)}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested admin_item" do
      item = FactoryGirl.create(:item)
      expect {
        delete :destroy, {id: item.id}, valid_session
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the items list" do
      item = FactoryGirl.create(:item)
      delete :destroy, {id: item.id}, valid_session
      expect(response).to redirect_to(admin_items_url)
    end
  end

end
