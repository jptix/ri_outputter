require "rdoc/ri/ri_driver"
require "pp"

module RiOutputter
  class Lookup < RiDriver
    alias_method :find, :get_info_for
  
    def initialize(formatter = HtmlFormatter)
      @formatter = formatter.new

      # ri command line options goes here, if we need them
      args = []
      original_args = ARGV.dup
      ARGV.replace(args)
      super()
      ARGV.replace(original_args)
    
      @display = self
    end
  
    def display_method_info(method)
      @formatter.markup_for_method(method)
    end
  
    def display_class_info(klass, ri_reader)
      @formatter.markup_for_class(klass)
    end
  
    def display_method_list(methods)
      @formatter.markup_for_method_list(methods)
    end
  
    def display_class_list(namespaces)
      @foramtter.markup_for_class_list(namespaces)
    end
  
    # not sure when these are called
    def list_known_classes(classes)
      raise NotImplementedError
    end

    def list_known_names(names)
      raise NotImplementedError
    end
  
  end
end

