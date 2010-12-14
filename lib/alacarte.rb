require 'alacarte/engine'
require 'alacarte/rails'
require 'alacarte/menus'
require 'alacarte/menu'

module Alacarte
  mattr_reader :menus
  @@menus = Alacarte::Menus.new
end