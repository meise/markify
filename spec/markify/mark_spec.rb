# encoding: utf-8
=begin
Copyright Daniel Meißner <meise+markify@3st.be>, 2013

This file is part of Markify.

Markify is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Markify is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Markify. If not, see <http://www.gnu.org/licenses/>.
=end

require 'spec_helper'

describe Markify::Mark do
  before do
    @mark = Markify::Mark.new('Peter Lustig', '2342', '3.0', 'BE', '2', '23.02.1942')
  end

  it "should be a string" do
    @mark.name.should == "Peter Lustig"
  end

  it "should be a integer" do
    @mark.id.should == 2342
  end

  it "should be a float" do
    @mark.mark.should == 3.0
  end

  it "should be a string" do
    @mark.passed.should == "BE"
  end

  it "should be a date" do
    @mark.date.should == Date.strptime("23.02.1942", '%d.%m.%Y')
  end

  it "should be a integer" do
    @mark.try.should == 2
  end

  describe "#to_s" do
    it "should return a string" do
      @mark.to_s.is_a?(String).should == true
    end
  end

  describe "#to_sha256"  do
    it "should return sha256 object" do
      @mark.to_sha256.is_a?(Digest::SHA256).should == true
    end

    it "should be generate a hash with the right order" do
      @hash = Digest::SHA256.new << "Peter Lustig2342#{Date.strptime("23.02.1942", '%d.%m.%Y')}3.02BE"
      @mark.to_sha256.should eq(@hash)
    end
  end
end