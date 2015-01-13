require 'rails_helper'

RSpec.describe "admin/items/new", :type => :view do
  before(:each) do
    assign(:item, FactoryGirl.build(:item))
  end

  it "renders new admin_item form" do
    render

    assert_select "form[action=?][method=?]", admin_items_path, "post" do

      assert_select "input#item_name[name=?]", "item[name]"

      assert_select "input#item_grade[name=?]", "item[grade]"

      assert_select "select#item_department[name=?]", "item[department]"
    end
  end
end
