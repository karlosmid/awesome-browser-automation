Then /^cart has Dark Thug Blue-Navy T-Shirt$/ do
  on CartPage do |page|
    expect(page.item_name).to eq "Dark Thug Blue-Navy T-Shirt"
  end
end