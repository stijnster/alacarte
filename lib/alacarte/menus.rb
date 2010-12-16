module Alacarte
  
  class Menus < Hash
    def draw(&block)
      self.instance_exec(&block)
    end

    def menu(name, *args, &block)
      self[name] = Menu.new(nil, :menu, name, *args, &block)
    end

  end
  
end