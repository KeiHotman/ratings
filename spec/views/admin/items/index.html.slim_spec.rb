require 'rails_helper'

RSpec.describe "admin/items/index", :type => :view do
  before(:each) do
    assign(:items, [
      FactoryGirl.create(:item, name: 'Name', grade: 1, department: 'information'),
      FactoryGirl.create(:item, name: 'Name', grade: 1, department: 'information')
    ])
  end

  it "renders a list of admin/items" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => '情報工学科', :count => 2
  end
end
