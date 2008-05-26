module RiOutputter
  module Display
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