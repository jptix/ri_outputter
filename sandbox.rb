require "lib/ri_outputter"

ri = RiOutputter::Lookup.new(:template_folder => File.dirname(__FILE__) + "/lib/ri_outputter/templates/ruby_class_browser")
puts ri.html_for("String")
# puts ri.html_for('Array#collect')
# puts ri.html_for('String#sp')
# puts ri.html_for('St')