require 'rails_helper'

RSpec.describe "admin/users/index", :type => :view do
  before(:each) do
    assign(:users, [
      FactoryGirl.create(:user, name: 'Name', grade: 1, department: 2),
      FactoryGirl.create(:user, name: 'Name', grade: 1, department: 2)
    ])
  end

  it "renders a list of admin/users" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
