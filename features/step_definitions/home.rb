Given /^I visit home page$/ do
  @browser.goto @app['SITE']
end
Then /^I am on home page$/ do
  expect(@browser.url).to eq @app['SITE']
end
Then /^I am not on home page$/ do
  expect(@browser.url).not_to eq @app['SITE']
end