require "erb"

module RiOutputter
  class HtmlFormatter

    Mixin = Struct.new(:name, :methods)

    def initialize(ri)
      @ri = ri
    end
  
    # Argument:
    #
    # method - RI::MethodDescription
    def markup_for_method(method)
      method.pretty_inspect
    end

    # Argument:
    #
    # klass - RI::ClassDescription
    def markup_for_class(klass)
      @class_template ||= File.read(File.dirname(__FILE__) + "/templates/class.erb")
      
      class_name             = klass.full_name
      class_description      = klass.comment.map { |c| c.respond_to?(:body) ? c.body : '' }.join("\n")
      
      class_includes = klass.includes.map do |mixin|
        name           = mixin.name
        included_class = @ri.get_info_for(name)
        methods        = included_class ? included_class.instance_methods : []
        Mixin.new(name, methods)
      end
      
      class_constants        = klass.constants
      class_methods          = klass.class_methods
      class_instance_methods = klass.instance_methods
      
      ERB.new(@class_template, 0, "%-<>").result(binding)
    end

    # Argument:
    #
    # methods - array of MethodEntry objects
    def markup_for_method_entries(method_entries)
      method_entries.pretty_inspect
    end

    # Argument:
    #
    # class_entries - array of ClassEntry objects
    def markup_for_class_entries(class_entries)
      class_entries.pretty_inspect
    end
    
    def link(string)
      string
    end
    
    def e(string)
      string
    end
  
  end
end