module Alacarte
  
  class Menu
    
    VALID_ELEMENTS = [:link, :span]
    
    attr_reader :parent, :type, :name, :deep_name, :path, :as, :label, :options, :items, :block, :html_options, :group_options
    
    def initialize(parent, type, *args, &block)
      @options = args.extract_options!.dup
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
    
    def block?
      !!@block
    end
    
    def self.env?
      !!@@env
    end
    
    def self.env
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