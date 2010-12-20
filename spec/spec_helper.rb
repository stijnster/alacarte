require 'I18n'
require File.dirname(__FILE__) + '/../lib/alacarte.rb'

# Add I18n load_path
# I18n.load_path = (I18n.load_path << Dir[File.join(File.dirname(__FILE__), 'locales', '*.yml')]).uniq

RSpec.configure do |c|
  
  c.before :each do
    Alacarte::Menu.reset_env!
  end

end