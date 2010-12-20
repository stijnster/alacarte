module Alacarte
  class Engine < ::Rails::Engine
    
    # Adding the Alacarte helper method to the Rails application
    config.to_prepare do
      ApplicationController.helper(AlacarteHelper)
    end

  end
end