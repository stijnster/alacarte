module Alacarte
  
  class Menus < Hash
    def draw(&block)
      self.instance_exec(&block)
    end

    def menu(name, &block)
      self[name] = Menu.new(:menu, name, &block)
    end

  end
  
end