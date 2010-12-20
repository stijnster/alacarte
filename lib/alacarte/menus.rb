module Alacarte
  
  # Alacarte::Menus provides a dsl for building menus.
  class Menus < Hash
    # Draw the menu
    def draw(&block)
      self.instance_exec(&block)
    end

    # Define a menu in a draw block
    def menu(name, *args, &block)
      self[name] = Menu.new(nil, :menu, name, *args, &block)
    end

  end
  
end