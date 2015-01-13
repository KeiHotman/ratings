require 'rails_helper'

RSpec.describe "admin/items/edit", :type => :view do
  before(:each) do
    @item = assign(:item, FactoryGirl.create(:item))
  end

  it "renders the edit admin_item form" do
    render

    assert_select "form[action=?][method=?]", admin_item_path(@item), "post" do

      assert_select "input#item_name[name=?]", "item[name]"

      assert_select "input#item_grade[name=?]", "item[grade]"

      assert_select "input#item_department[name=?]", "item[department]"
    end
  end
end
