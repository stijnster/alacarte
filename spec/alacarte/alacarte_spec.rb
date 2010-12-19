require 'spec_helper'

describe :alacarte do
  
  before :all do
  end
  
  it "should be possible to access the menus" do
    Alacarte.menus.should be_instance_of Alacarte::Menus
    Alacarte.menus.size.should eql 0
  end
  
end