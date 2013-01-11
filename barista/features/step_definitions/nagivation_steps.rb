When /^I go to the "(.*?)" listing page$/ do |arg1|
  # expecting the name of a resource here.
  # puts arg1.underscore.downcase.pluralize
  visit ('/' + arg1.underscore.downcase.pluralize)
end
