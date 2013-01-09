require 'spec_helper'

describe "store_configs/show" do
  before(:each) do
    @store_config = assign(:store_config, stub_model(StoreConfig,
      :name => "Name",
      :value => "Value"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Value/)
  end
end
