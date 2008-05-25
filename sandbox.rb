require "lib/ri_outputter"

ri = RiOutputter::Lookup.new
puts ri.find('String#split')