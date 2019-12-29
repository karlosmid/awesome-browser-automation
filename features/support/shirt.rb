class ShirtPage
    include PageObject
    
    page_url "<%=params[:base_url]%>"

    div(:add_to_cart, :xpath => '//*[@id="root"]/main/div[2]/div[3]/div[4]')
end