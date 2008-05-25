require "erb"
require "rubygems"
require "ruby-debug"

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
      @method_template ||= File.read(File.dirname(__FILE__) + "/templates/method.erb")
      
      method_name        = method.full_name
      method_parameters  = method.params
      method_example     = method.comment.select { |c| SM::Flow::VERB === c }
      method_description = (method.comment - method_example)

      method_description = method_description.map do |c|
        c.respond_to?(:body) ? c.body.gsub(/(\A|\n)\s+/, '\1  ') : ''
      end.join("\n")
      
      method_example = method_example.map do |c|
        c.respond_to?(:body) ? c.body.gsub(/(\A|\n)\s+/, '\1  ') : ''
      end.join("\n")

      
      method_aliases = method.aliases
      ERB.new(@method_template, 0, "%-<>").result(binding)
    end

    # Argument:
    #
    # klass - RI::ClassDescription
    def markup_for_class(klass)
      @class_template ||= File.read(File.dirname(__FILE__) + "/templates/class.erb")
      
      class_name        = klass.full_name
      class_description = klass.comment.map { |c| c.respond_to?(:body) ? c.body : '' }.join("\n").strip
      
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
      @multiple_matches_template ||= File.read(File.dirname(__FILE__) + "/templates/multiple_matches.erb")
      objects = method_entries
      ERB.new(@multiple_matches_template, 0, "%-<>").result(binding)
    end

    # Argument:
    #
    # class_entries - array of ClassEntry objects
    def markup_for_class_entries(class_entries)
      @multiple_matches_template ||= File.read(File.dirname(__FILE__) + "/templates/multiple_matches.erb")
      objects = class_entries
      ERB.new(@multiple_matches_template, 0, "%-<>").result(binding)
    end
    
    def link(string)
      string
    end
    
    def e(text); text.gsub(/&/, '&amp;').gsub(/</, '&lt;').gsub(/>/, '&gt;') end
  
  end
end