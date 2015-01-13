require 'rails_helper'

RSpec.describe "admin/users/edit", :type => :view do
  before(:each) do
    @user = assign(:user, FactoryGirl.create(:user))
  end

  it "renders the edit admin_user form" do
    render

    assert_select "form[action=?][method=?]", admin_user_path(@user), "post" do
      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_grade[name=?]", "user[grade]"

      assert_select "input#user_department[name=?]", "user[department]"
    end
  end
end
