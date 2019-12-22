Given /^I visit home page$/ do
  visit(HomePage,
        using_params:
        {base_url: @app["SITE"]}
  )
end
Then /^I am on home page$/ do
  expect(on(HomePage).url).to eq @app['SITE']
end
Then /^I am not on home page$/ do
  expect(on(HomePage).url).not_to eq @app['SITE']
end