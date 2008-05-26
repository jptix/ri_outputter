require File.dirname(__FILE__) + "/spec_helper"

describe RiOutputter::Lookup do
  before(:all) do
    @ri = RiOutputter::Lookup.new
  end

  describe "#html_for" do
    # ==========
    # = Method =
    # ==========
    it "should output some nice HTML for 'Array#sort'" do
      result = @ri.html_for("Array#sort")
      result.should include('<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"')
    end

    # =========
    # = Class =
    # =========
    it "should output some nice HTML for 'String'" do
      result = @ri.html_for("String")
      result.should include('<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"')
    end

    # =====================
    # = Incomplete method =
    # =====================
    it "should output some nice HTML for 'sor'" do
      result = @ri.html_for("sor")
      result.should include('<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"')
    end

    # =====================
    # = Incomplete class  =
    # =====================
    it "should output some nice HTML for 'Str'" do
      result = @ri.html_for("Str")
      result.should include('<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"')
    end

    # ==============
    # = Exceptions =
    # ==============
    it "should return nil when it doesn't find a match" do
      @ri.html_for("foobarbaz").should be_nil
    end
  end


end
