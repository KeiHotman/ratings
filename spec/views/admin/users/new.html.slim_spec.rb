require 'rails_helper'

RSpec.describe "admin/users/new", :type => :view do
  before(:each) do
    assign(:user, FactoryGirl.build(:user))
  end

  it "renders new admin_user form" do
    render

    assert_select "form[action=?][method=?]", admin_users_path, "post" do
      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_grade[name=?]", "user[grade]"

      assert_select "input#user_department[name=?]", "user[department]"
    end
  end
end
