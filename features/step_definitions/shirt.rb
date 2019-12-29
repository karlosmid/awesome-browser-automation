When /^I select Dark Thug Blue-Navy T-Shirt$/ do
  on ShirtPage do |page|
    page.add_to_cart_element.click
    sleep 1
  end
end