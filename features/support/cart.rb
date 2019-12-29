class CartPage
    include PageObject
    
    page_url "<%=params[:base_url]%>"

    p(:item_name, :xpath => '//*[@id="root"]/div/div[2]/div[2]/div/div[3]/p[1]')
end