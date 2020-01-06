class CartPage
    include PageObject
    
    page_url "<%=params[:base_url]%>"

    def check name
      element("p", {:class => 'title', :text => name}).when_visible.text
    end
end