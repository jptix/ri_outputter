require "benchmark"

TESTS = 1
Benchmark.bmbm do |results|
  results.report("ri     - Array#sort") do 
    TESTS.times { `ri "Array#sort"`}
  end
  results.report("ri     - Array#foobarbaz") do 
    TESTS.times { `ri "Array#foobarbaz"`}
  end
  results.report("fastri - Array#sort") do 
    TESTS.times { `fri "Array#sort"`}
  end
  results.report("fastri - Array#foobarbaz") do 
    TESTS.times { `fri "Array#foobarbaz"`}
  end
  
  results.report("ri     - Array") do 
    TESTS.times { `ri "Array"`}
  end
  results.report("ri     - FooBarBaz") do 
    TESTS.times { `ri "FooBarBaz"`}
  end
  results.report("fastri - Array") do 
    TESTS.times { `fri "Array"`}
  end
  results.report("fastri - FooBarBaz") do 
    TESTS.times { `fri "FooBarBaz"`}
  end
  
  
end