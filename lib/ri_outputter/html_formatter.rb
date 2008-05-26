require "erb"

module RiOutputter
  class HtmlFormatter

    Mixin = Struct.new(:name, :methods)

    def initialize(ri)
      @ri = ri
      template_folder = @ri.template_folder || File.dirname(__FILE__) + "/templates/textmate"
      @template_paths = {
        :method           => File.join(template_folder, "method.erb"),
        :class            => File.join(template_folder, "class.erb"),
        :multiple_matches => File.join(template_folder, "multiple_matches.erb")
      }
      @template_paths.values.each do |path|
        raise Errno::ENOENT, path unless File.exist?(path)
      end
      
      stylesheet = File.join(template_folder, 'stylesheet.css')
      @stylesheet = stylesheet if File.exist?(stylesheet)
    end
  
    # Argument:
    #
    # method - RI::MethodDescription
    def markup_for_method(method)
      @method_template ||= File.read @template_paths[:method]
      
      method_name        = method.full_name
      method_parameters  = method.params
      method_description = method.comment ? flow_to_html(method.comment) : ''
      
      method_aliases = method.aliases
      ERB.new(@method_template, 0, "%-<>").result(binding)
    end

    # Argument:
    #
    # klass - RI::ClassDescription
    def markup_for_class(klass)
      @class_template ||= File.read @template_paths[:class]
      
      class_name = klass.full_name
      class_description = klass.comment ? flow_to_html(klass.comment) : ''
      
      if klass.includes
        class_includes = klass.includes.map do |mixin|
          name           = mixin.name
          included_class = @ri.struct_for(name)
          methods        = included_class ? included_class.instance_methods : []
          Mixin.new(name, methods)
        end
      else
        class_includes = []
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
      @multiple_matches_template ||= File.read @template_paths[:multiple_matches] 
      objects = method_entries
      ERB.new(@multiple_matches_template, 0, "%-<>").result(binding)
    end

    # Argument:
    #
    # class_entries - array of ClassEntry objects
    def markup_for_class_entries(class_entries)
      @multiple_matches_template ||= File.read @template_paths[:multiple_matches] 
      objects = class_entries
      ERB.new(@multiple_matches_template, 0, "%-<>").result(binding)
    end
    
    private
    
    def flow_to_html(comments)
      comments.map do |c|
        if c.respond_to?(:body) 
          c.body.gsub(/^  .*\n(^  .*\n|^$\n(?=  |$))*/, '<pre>\0</pre>')
        else
          ''
        end
      end.join("\n").strip
    end
    
    def link(text)
      e text
    end
    
    def e(text); text.gsub(/&/, '&amp;').gsub(/</, '&lt;').gsub(/>/, '&gt;') end
    
  end
end