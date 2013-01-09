require 'spec_helper'

describe "menu_items/show" do
  before(:each) do
    @menu_item = assign(:menu_item, stub_model(MenuItem,
      :name => "Name",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Description/)
  end
end
