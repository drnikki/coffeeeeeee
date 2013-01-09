require 'spec_helper'

describe "store_configs/new" do
  before(:each) do
    assign(:store_config, stub_model(StoreConfig,
      :name => "MyString",
      :value => "MyString"
    ).as_new_record)
  end

  it "renders new store_config form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => store_configs_path, :method => "post" do
      assert_select "input#store_config_name", :name => "store_config[name]"
      assert_select "input#store_config_value", :name => "store_config[value]"
    end
  end
end
