begin
  require "rubygems"
rescue LoadError
end

require 'fastri/ri_service'

module RiOutputter
  class FastRiDriver < FastRI::RiService
    include Display
        
    def initialize(options = {})
      if File.exist?(index_file = File.expand_path("~/.fastri-index"))
        index = File.open(index_file, "rb") { |io| Marshal.load io } 
      else
        index = FastRI::RiIndex.new_from_paths(RI::Paths::PATH)
      end
      
      super(index)
    end
    
    def display(arg)
      self
    end
    
    def capture_stdout(display)
      # nothingness
    end

    def lookup(query)
      info(query)
    end
    
    def info(keyw)
      return nil if keyw.strip.empty?
      begin
        case (entries = obtain_entries(NameDescriptor.new(keyw), DEFAULT_INFO_OPTIONS)).size
        when 0; nil
        when 1
          case entries[0].type
          when :namespace
              @ri_reader.get_class(entries[0])
          when :method
              @ri_reader.get_method(entries[0])
          end
        else
          # potential source of bugs if entries contain both methods and classes, and they're formatted differently.. 
          entries.map! do |entry|
            entry.type == :method ? @ri_reader.get_method(entry) : @ri_reader.get_class(entry)
          end
        end
      rescue RiError
      end
    end
    
  end
end

