module Rails
  class Application
    
    # Provides an entry point for the Rails application to the Alacarte +menus+ attribute.
    def menus
      Alacarte.menus
    end
    
  end
end