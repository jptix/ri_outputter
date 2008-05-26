require "pp"
require "rdoc/ri/ri_driver"

module RiOutputter
  class Driver < RiDriver
    include Display
        
    def initialize(options = {})
      args = %w() # ri command line options goes here, if we need them
      original_args = ARGV.dup
      ARGV.replace(args)
      super()
      ARGV.replace(original_args)
    
      @display = self
    end
    
    def lookup(query)
      begin
        get_info_for(query)
      rescue RiError
      end
    end
  end
end

