module Alacarte
  
  # Alacarte::Menu is the base class for defining menu items.
  class Menu
    
    VALID_ELEMENTS = [:link, :span]
    @@env = nil
    
    attr_reader :parent, :type, :name, :deep_name, :path, :as, :label, :options, :items, :block, :html_options, :group_options
    
    # Tests if an environment was set to the Alacarte::Menu
    def self.env?
      !!@@env
    end
    
    # Returns the environment that was set to the Alacarte::Menu
    def self.env
      @@env
    end
    
    # Creates a menu item. Menu items can relate to a +parent+ menu item and a type should be passed. The type can be used for
    # rendering (current types are +:menu+, +:link+ and +:span+).
    #
    # The first two attributes that can be passed (not required) are the +name+ and +path+ of the menu item. These can also
    # be set in the options hash. Other settings are derived from +name+, but can also be passed in the options hash.
    #
    # The options you can pass are:
    # * +:name+ sets the name of the menu item
    # * +:path+ sets the path that the menu item should link to
    # * +:label+ sets the label that should be displayed as the menu item
    # * +:as+ defines how the element can be matched with the current element
    # * +:if+ set a conditions when the menu item should be valid
    # * +:unless+ set an inverse conditions when the menu item should be valid
    # * +:html+ pass any html options that you want to be added to the menu item
    # * +:group+ when the menu item has valid children, the +group+ options are passed as the html options of the grouping element
    def initialize(parent, type, *args, &block)
      @options = args.last.is_a?(::Hash) ? args.pop : {}
      @parent = parent
      @type = type
      @name = options[:name] || args[0]
      @path = options[:path] || args[1]
      @deep_name = @parent ? "#{@parent.deep_name}.#{@name.to_s}" : @name.to_s
      @label = options[:label] || I18n.t("alacarte.menus.#{@deep_name}", :default => @deep_name.to_s)
      @as = options[:as] || @name
      @block = block if block_given?
      @html_options = options[:html]
      @group_options = options[:group]

      build
    end
    
    # Tests if a block was passed to the Alacarte::Menu object
    def block?
      !!@block
    end
    
    # Builds the menu, based on the environment that is passed.
    def build(env = nil)
      @@env = env if env
      @items = []

      self.instance_eval(&@block) if Menu.env? && self.block?
    end
    
    # Tests to see if the current menu item is valid in the current setting
    def valid?
      if options[:if] && options[:if].respond_to?(:call)
        return options[:if].call
      end

      if options[:unless] && options[:unless].respond_to?(:call)
        return !options[:unless].call
      end
      
      return true
    end

    # Try to send the menu to the passed +env+, then try to create a menu item of the missing method.
    def method_missing(id, *args, &block)
      if Menu.env? && Menu.env.respond_to?(id)
        @@env.send(id, *args, &block)
      elsif VALID_ELEMENTS.member?(id)
        @items << Menu.new(self, id, *args, &block)
      else
        super
      end
    end
  end
  
end