require 'rails_helper'

RSpec.describe "admin/items/index", :type => :view do
  before(:each) do
    assign(:items, [
      Item.create!(
        :name => "Name",
        :grade => 1,
        :department => 2
      ),
      Item.create!(
        :name => "Name",
        :grade => 1,
        :department => 2
      )
    ])
  end

  it "renders a list of admin/items" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
