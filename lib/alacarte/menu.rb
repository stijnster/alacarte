module Alacarte
  
  class Menu
    
    VALID_ELEMENTS = [:link, :span]
    
    cattr_reader :env
    attr_reader :type, :name, :path, :as, :label, :options, :items, :block, :html_options
    
    def initialize(type, *args, &block)
      @options = args.extract_options!.dup
      @type = type
      @name = options[:name] || args[0]
      @path = options[:path] || args[1]
      @label = options[:label] || I18n.t("alacarte.menus.#{@name.to_s}", :default => @name.to_s)
      @as = options[:as] || @name
      @block = block if block_given?
      @html_options = options[:html]

      build
    end
    
    def block?
      !!@block
    end
    
    def self.env?
      !!@@env
    end
    
    def build(env = nil)
      @@env = env if env
      @items = []

      self.instance_eval(&@block) if Menu.env? && self.block?
    end
    
    def valid?
      if options[:if] && options[:if].respond_to?(:call)
        return options[:if].call
      end

      if options[:unless] && options[:unless].respond_to?(:call)
        return !options[:unless].call
      end
      
      return true
    end
    
    def method_missing(id, *args)
      if Menu.env? && Menu.env.respond_to?(id)
        @@env.send(id, *args)
      elsif VALID_ELEMENTS.member?(id)
        @items << Menu.new(id, *args)
      else
        super
      end
    end
  end
  
end