When /^I select (.*)$/ do |name|
  on ShirtPage do |page|
    page.select(name)
  end
end