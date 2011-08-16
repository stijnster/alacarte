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
    
    it "should be possible to specify an 'as'" do
      @menu = Alacarte::Menu.new(nil, :span, :as => 'spacestation')
      @menu.as.should eql 'spacestation'
            
      @menu = Alacarte::Menu.new(nil, :link, 'login', :as => 'login_button')
      @menu.name.should eql 'login'
      @menu.as.should eql 'login_button'
    end
    
  end
    
  it "should set the env property when the menu is built" do
    @menu = Alacarte::Menu.new(nil, :menu, :as => 'account')
    Alacarte::Menu.env?.should be_false
    Alacarte::Menu.env.should be_nil
    
    @menu.build
    Alacarte::Menu.env?.should be_false
    Alacarte::Menu.env.should be_nil

    @object = Object.new
    @menu.build(@object)
    Alacarte::Menu.env?.should be_true
    Alacarte::Menu.env.should eql @object    
  end
  
  it "should be possible to reset the env property" do
    Alacarte::Menu.env?.should be_false
    Alacarte::Menu.env.should be_nil

    @menu = Alacarte::Menu.new(nil, :menu, :as => 'account')
    @object = Object.new
    @menu.build(@object)
    Alacarte::Menu.env?.should be_true
    Alacarte::Menu.env.should eql @object
    
    Alacarte::Menu.reset_env!
    Alacarte::Menu.env?.should be_false
    Alacarte::Menu.env.should be_nil
  end
  
  it "should be able to test if a block was set on the menu" do
    @menu = Alacarte::Menu.new(nil, :menu, :as => 'account') do
      link :login, '/login'
      link :logout, '/logout'
    end
    @menu.block?.should be_true
    
    @menu = Alacarte::Menu.new(nil, :menu, :as => 'account')
    @menu.block?.should be_false
  end
  
  it "should return the correct valid state for if statements" do
    @menu = Alacarte::Menu.new(nil, :menu, :if => lambda{ 4 == 3 })
    @menu.valid?.should be_false

    @menu = Alacarte::Menu.new(nil, :menu, :if => lambda{ 4 == 4 })
    @menu.valid?.should be_true
  end
  
  it "should return the correct valid state for unless statements" do
    @menu = Alacarte::Menu.new(nil, :menu, :unless => lambda{ 4 == 3 })
    @menu.valid?.should be_true

    @menu = Alacarte::Menu.new(nil, :menu, :unless => lambda{ 4 == 4 })
    @menu.valid?.should be_false
  end    
  
  it "should add .root to the translation key of a root link or span element" do
    @menu = Alacarte::Menu.new(nil, :menu, 'name') do
      link :global, '/global'
      link :account, '/account' do
        link :settings, '/settings'
        link :logout, '/logout'
      end
    end
    
    @object = Object.new
    
    @menu.build(@object)
    @menu.deep_name.should eql 'name'
    @menu.items.first.deep_name.should eql 'name.global'
    @menu.items.last.deep_name.should eql 'name.account'
    @menu.items.last.translation_key.should eql 'name.account.root'
    @menu.items.last.items.first.deep_name.should eql 'name.account.settings'
    @menu.items.last.items.first.translation_key.should eql 'name.account.settings'
    @menu.items.last.items.last.deep_name.should eql 'name.account.logout'
    @menu.items.last.items.last.translation_key.should eql 'name.account.logout'
  end
end