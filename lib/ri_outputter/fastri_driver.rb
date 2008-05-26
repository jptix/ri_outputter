module RiOutputter
  class FastRiDriver < FastRI::RiService
    include Display
        
    def initialize(options = {})
      super(FastRI::RiIndex.new_from_paths(RI::Paths::PATH))
    end
    
    def display(arg)
      self
    end
    
    def capture_stdout(display)
      # nothingness
    end

    def lookup(query)
      raise RiError, "Nothing found for #{query}" unless res = info(query)
      res
    end
    
    def info(keyw, options = {})
      options = DEFAULT_INFO_OPTIONS.merge(options)
      return nil if keyw.strip.empty?
      descriptor = NameDescriptor.new(keyw)
      entries = obtain_entries(descriptor, options)
      
      begin
        case entries.size
        when 0; nil
        when 1
          case entries.first.type
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
        return nil
      end
    end
    
  end
end

