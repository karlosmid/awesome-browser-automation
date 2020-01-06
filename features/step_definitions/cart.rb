Then /^cart has (.*)$/ do |name|
  on CartPage do |page|
    expect(page.check(name)).to eq name
  end
end