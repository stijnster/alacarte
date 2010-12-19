require 'spec_helper'

describe Alacarte::Menu do
  
  context "when creating a menu" do
    
    it "should be possible to create an item with its minimal settings" do
      @menu = Alacarte::Menu.new(nil, :menu)
      
      @menu.name.should be_nil
      @menu.path.should be_nil
    end

    it "should be possible to pass in a name" do
      @menu = Alacarte::Menu.new(nil, :menu, 'name')
      @menu.name.should eql 'name'
      @menu.label.should eql 'name'
      @menu.deep_name.should eql 'name'
      @menu.as.should eql 'name'

      @menu = Alacarte::Menu.new(nil, :menu, :name => 'other name')
      @menu.name.should eql 'other name'
      @menu.label.should eql 'other name'
      @menu.deep_name.should eql 'other name'
      @menu.as.should eql 'other name'
    end
    
    it "should be possible to pass in a path" do      
      @menu = Alacarte::Menu.new(nil, :link, 'login', '/accounts/login')
      @menu.path.should eql '/accounts/login'
      
      @menu = Alacarte::Menu.new(nil, :link, 'logout', :path => '/accounts/logout')
      @menu.path.should eql '/accounts/logout'
    end
    
    it "should be possible to specify a label" do
      @menu = Alacarte::Menu.new(nil, :span, :label => 'spacer')
      @menu.label.should eql 'spacer'
            
      @menu = Alacarte::Menu.new(nil, :link, 'login', :label => 'Log in here!')
      @menu.name.should eql 'login'
      @menu.label.should eql 'Log in here!'
    end
    
  end
  
end