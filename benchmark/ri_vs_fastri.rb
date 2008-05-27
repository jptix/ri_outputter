require "benchmark"

require File.dirname(__FILE__) + "/../lib/ri_outputter"
require File.dirname(__FILE__) + "/../lib/ri_outputter/driver"
require File.dirname(__FILE__) + "/../lib/ri_outputter/fastri_driver"

ri = RiOutputter::Driver.new
fast_ri = RiOutputter::FastRiDriver.new

TESTS = 1
Benchmark.bmbm do |results|
  results.report("ri     - Array#sort") do 
    TESTS.times { ri.lookup("Array#sort")}
  end
  results.report("ri     - Array#foobarbaz") do 
    TESTS.times { ri.lookup("Array#foobarbaz")}
  end
  results.report("fastri - Array#sort") do 
    TESTS.times { fast_ri.lookup("Array#sort")}
  end
  results.report("fastri - Array#foobarbaz") do 
    TESTS.times { fast_ri.lookup("Array#foobarbaz")}
  end
  
  results.report("ri     - Array") do 
    TESTS.times { ri.lookup("Array")}
  end
  results.report("ri     - FooBarBaz") do 
    TESTS.times { ri.lookup("FooBarBaz")}
  end
  results.report("fastri - Array") do 
    TESTS.times { fast_ri.lookup("Array")}
  end
  results.report("fastri - FooBarBaz") do 
    TESTS.times { fast_ri.lookup("FooBarBaz")}
  end
  
  
end