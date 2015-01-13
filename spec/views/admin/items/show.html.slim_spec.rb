require 'rails_helper'

RSpec.describe "admin/items/show", :type => :view do
  before(:each) do
    @item = assign(:item, FactoryGirl.create(:item))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(Regexp.new(@item.name))
    expect(rendered).to match(Regexp.new(@item.grade.to_s))
    expect(rendered).to match(Regexp.new(@item.department.to_s))
  end
end
