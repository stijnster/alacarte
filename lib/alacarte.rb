require 'alacarte/engine' if defined?(Rails)
require 'alacarte/rails' if defined?(Rails)
require 'alacarte/menus'
require 'alacarte/menu'

module Alacarte
  @@menus = Alacarte::Menus.new

  # menus provides an access point to the Alacarte module +menus+ attribute.
  def self.menus
    @@menus
  end
end