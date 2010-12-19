require 'alacarte/engine' if defined?(Rails)
require 'alacarte/rails' if defined?(Rails)
require 'alacarte/menus'
require 'alacarte/menu'

module Alacarte
  @@menus = Alacarte::Menus.new
  
  def self.menus
    @@menus
  end
end