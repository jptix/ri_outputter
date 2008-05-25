require "rdoc/ri/ri_driver"
require "pp"

module RiOutputter
  class Lookup < RiDriver
    def initialize(formatter = HtmlFormatter)
      @formatter = formatter.new(self)

      # ri command line options goes here, if we need them
      args = []
      original_args = ARGV.dup
      ARGV.replace(args)
      super()
      ARGV.replace(original_args)
    
      @display = self
    end
    
    def find(query)
      result = get_info_for(query)
      case result
      when RI::MethodDescription
        @formatter.markup_for_method(result)
      when RI::ClassDescription
        @formatter.markup_for_class(result)
      when Array
        case result.first
        when RI::ClassEntry
          @formatter.markup_for_class_entries(result)
        when RI::MethodEntry
          @formatter.markup_for_method_entries(result)
        end
      end
    end
  
    def display_method_info(method)
      method
    end
  
    def display_class_info(klass, ri_reader)
      klass
    end
  
    def display_method_list(method_entries)
      method_entries
    end
  
    def display_class_list(class_entries)
      class_entries
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

