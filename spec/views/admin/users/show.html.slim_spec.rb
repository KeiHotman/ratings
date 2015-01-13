require 'rails_helper'

RSpec.describe "admin/users/show", :type => :view do
  before(:each) do
    @user = assign(:user, FactoryGirl.create(:user))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(Regexp.new(@user.name))
    expect(rendered).to match(Regexp.new(@user.grade.to_s))
    expect(rendered).to match(Regexp.new(I18n.t("constant.departments.#{@user.department}")))
  end
end
