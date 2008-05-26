require "pp"

module RiOutputter
  class Lookup
    attr_reader :template_folder
    # Used to do perform ri queries.
    # Options:
    #
    #  * :template_folder => a folder that contains class.erb, method.erb and multiple_matches.erb
    #  * :formatter       => a formatter class 
    #  * :driver          => a driver class
    def initialize(options = {})
      @template_folder = options[:template_folder]
      @formatter       = (options[:formatter] || HtmlFormatter).new(self)

      begin
        require "rubygems"
        require 'fastri/ri_service'
        require File.dirname(__FILE__) + "/fastri_driver"
        @driver = FastRiDriver.new
      rescue LoadError
        @driver = Driver.new
      end
      
    end

    # Returns HTML output for the given query.
    # If you need the data objects themselves, use Lookup#struct_for(query)
    def html_for(query)
      result = @driver.lookup(query)
      case result
      when RI::MethodDescription
        @formatter.markup_for_method(result)
      when RI::ClassDescription
        @formatter.markup_for_class(result)
      when Array
        case result.first
        when RI::ClassEntry, RI::ClassDescription
          @formatter.markup_for_class_entries(result)
        when RI::MethodEntry, RI::MethodDescription
          @formatter.markup_for_method_entries(result)
        end
      else
        # @formatter.markup_for_not_found(query) ??
      end
    end
    
    # Return the resulting Ruby struct for this query
    def struct_for(query)
      @driver.lookup(query)
    end
  end
end

