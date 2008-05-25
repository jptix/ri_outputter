require File.dirname(__FILE__) + "/spec_helper"

describe RiOutputter::Lookup do
  before(:all) do
    @ri = RiOutputter::Lookup.new
  end
    
  # ==========
  # = Method =
  # ==========
  describe "#html_for('Array#sort')" do
    it "should output some nice HTML" do
      result = @ri.html_for("Array#sort")
      result.should include('<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"')
    end
  end
  
  # =========
  # = Class =
  # =========
  describe "#html_for('String')" do
    it "should output some nice HTML" do
      result = @ri.html_for("String")
      result.should include('<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"')
    end
  end

  # =====================
  # = Incomplete method =
  # =====================
  describe "#html_for('sor')" do
    it "should output some nice HTML" do
      result = @ri.html_for("Str")
      result.should include('<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"')
    end
  end

  # =====================
  # = Incomplete method =
  # =====================
  describe "#html_for('Str')" do
    it "should output some nice HTML" do
      result = @ri.html_for("Str")
      result.should include('<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"')
    end
  end

  
end