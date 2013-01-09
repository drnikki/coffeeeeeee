require 'spec_helper'

describe "store_configs/edit" do
  before(:each) do
    @store_config = assign(:store_config, stub_model(StoreConfig,
      :name => "MyString",
      :value => "MyString"
    ))
  end

  it "renders the edit store_config form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => store_configs_path(@store_config), :method => "post" do
      assert_select "input#store_config_name", :name => "store_config[name]"
      assert_select "input#store_config_value", :name => "store_config[value]"
    end
  end
end
