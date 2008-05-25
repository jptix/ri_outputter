require File.dirname(__FILE__) + "/spec_helper"

describe RiOutputter::Lookup do
  before(:all) do
    @ri = RiOutputter::Lookup.new
  end
    
  # =================
  # = Method lookup =
  # =================
  describe "#find('Array#sort')" do
    it "should output some nice HTML" do
      result = @ri.find("Array#sort")
      result.should include('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"')
      # puts result
    end
  end

end