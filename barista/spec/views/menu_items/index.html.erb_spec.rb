require 'spec_helper'

describe "menu_items/index" do
  before(:each) do
    assign(:menu_items, [
      stub_model(MenuItem,
        :name => "Name",
        :description => "Description"
      ),
      stub_model(MenuItem,
        :name => "Name",
        :description => "Description"
      )
    ])
  end

  it "renders a list of menu_items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
