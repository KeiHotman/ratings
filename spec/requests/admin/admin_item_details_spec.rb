require 'rails_helper'

RSpec.describe "Admin::ItemDetails", :type => :request do
  describe "GET /admin_item_details" do
    it "works! (now write some real specs)" do
      get admin_item_details_path
      expect(response.status).to be(200)
    end
  end
end
