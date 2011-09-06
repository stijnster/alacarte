module AlacarteHelper
  
  def navigation_for(menu, current_element = nil)
    current_element = controller_name if current_element.blank?
    
    if current_menu = Alacarte.menus[menu]
      current_menu.build(self)
      
      return elements_for(current_menu, current_element.to_sym)
    end
  end
  
  def elements_for(menu, current_element)
    result = ''
    
    menu.items.each do |item|
      if item.valid?
        _html_options = item.html_options || {}
        _html_options[:class] = _html_options[:class].to_s.insert(0, 'active ').strip if (current_element == item.as)
      
        _item = case item.type
          when :link: link_to(item.label.html_safe, item.path, _html_options)
          else content_tag(item.type, item.label, _html_options)
        end
        
        if item.items.size > 0
          _item << elements_for(item, current_element)
        end
      
        result << content_tag(:li, _item, item.wrapper_options)
      end
    end
    
    result.blank? ? '' : content_tag(:ul, result.html_safe, menu.group_options)
  end

end
