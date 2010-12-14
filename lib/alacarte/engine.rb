module Alacarte
  class Engine < ::Rails::Engine
    
    config.to_prepare do
      ApplicationController.helper(AlacarteHelper)
    end

  end
end