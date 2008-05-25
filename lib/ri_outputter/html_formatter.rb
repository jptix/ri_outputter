module RiOutputter
  class HtmlFormatter
  
    # Argument:
    #
    # method - RI::MethodDescription
    def markup_for_method(method)
      out = ''
      out << header
      # code
      out << method.pretty_inspect
      out << footer
      out
    end

    # Argument:
    #
    # klass - RI::ClassDescription
    def markup_for_class(klass)
      out = ''
      out << header
      # code
      out << klass.pretty_inspect    
      out << footer
    end

    # Argument:
    #
    # methods - array of MethodEntry objects
    def markup_for_method_list(method_entries)
      out = ''
      out << header
      # code
      out << method_entries.pretty_inspect
      out << footer
    end

    # Argument:
    #
    # class_entries - array of MethodEntry objects
    def markup_for_class_list(class_entries)
      out = ''
      out << header
      # code
      out << class_entries.pretty_inspect
      out << footer
    end
  
    private
  
    def header
      <<-HTML
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml">
  	<head>
  		<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
  		<title>
  			Ri Documentation
  		</title>
  	</head>
  	<body>    
    HTML
    end
  
    def footer
     <<-HTML
   
     	</body>
     </html>
     HTML
    end
  end
  
end