class ShirtPage
    include PageObject
    
    page_url "<%=params[:base_url]%>"
    
    def select name
      element("p", {:text => name}).when_visible.siblings[1].click
    end
end