require "lib/ri_outputter"

ri = RiOutputter::Lookup.new(:template_folder => File.dirname(__FILE__) + "/lib/templates/ruby_class_browser")
puts ri.find("String")
# puts ri.find('Set#collect')
# puts ri.find('String#sp')
# puts ri.find('St')