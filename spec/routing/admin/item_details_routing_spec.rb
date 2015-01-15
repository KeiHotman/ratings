require "rails_helper"

RSpec.describe Admin::ItemDetailsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/item_details").to route_to("admin/item_details#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/item_details/new").to route_to("admin/item_details#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/item_details/1").to route_to("admin/item_details#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/item_details/1/edit").to route_to("admin/item_details#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/item_details").to route_to("admin/item_details#create")
    end

    it "routes to #update" do
      expect(:put => "/admin/item_details/1").to route_to("admin/item_details#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/item_details/1").to route_to("admin/item_details#destroy", :id => "1")
    end

  end
end
