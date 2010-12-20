require 'spec_helper'

describe Alacarte::Menus do
  
  before do
    @menus = Alacarte::Menus.new
  end
  
  it "should be possible to draw menus using a block" do
    @menus.size.should eql 0
    
    @menus.draw do
      menu :one
      menu :two
    end
    
    @menus.size.should eql 2
    @menus.keys.first.should eql :one
    @menus.keys.last.should eql :two

    @menus.values.each do |menu|
      menu.should be_instance_of Alacarte::Menu
    end
  end
  
  it "should be possible to create a menu directly" do
    @menus.size.should eql 0
    @menus.menu :three
    @menus.size.should eql 1
    @menus.keys.first.should eql :three
  end
  
  it "should construct menu items when the build command is issued" do
    @menus.size.should eql 0
    @menus.draw do
      menu :account do
        link :account, '/account' do
          link :avatar, '/account/avatar'
          link :edit, '/account/edit'
        end
        link :login, '/login'
        link :logout, '/logout'
      end
    end
    
    @menus.size.should eql 1
    @menus[:account].items.size.should eql 0
    
    @menus[:account].build(Object.new)
    @menus[:account].items.size.should eql 3
    @menus[:account].items.first.items.size.should eql 2
  end
  
end