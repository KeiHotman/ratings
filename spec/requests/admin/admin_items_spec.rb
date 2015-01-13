require 'rails_helper'

RSpec.describe "Admin::Items", :type => :request do
  describe "GET /admin/items" do
    it "works! (now write some real specs)" do
      get admin_items_path
      expect(response.status).to be(200)
    end
  end
end
