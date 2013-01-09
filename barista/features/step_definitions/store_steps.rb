Given /^the store is closed$/ do
  StoreConfig.find_or_create_by_name('status').update_attributes(:value => 'closed')
end

When /^I go to store settings page$/ do
  visit ('/store_configs')
end

When /^I edit "(.*?)"$/ do |arg1|
  @store = StoreConfig.find_by_name(arg1)
  visit(edit_store_config_path(@store.id))
  fill_in('Value', :with => 'open')
  click_on ('Update Store config')
end

Then /^"(.*?)" should be modified$/ do |arg1|
  @store = StoreConfig.find_by_name(arg1)
  @store.value.should == 'open'
end