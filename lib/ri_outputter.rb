$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || 
  $:.include?(File.expand_path(File.dirname(__FILE__)))


require "ri_outputter/display"
require "ri_outputter/driver"
require "ri_outputter/lookup"
require "ri_outputter/html_formatter"