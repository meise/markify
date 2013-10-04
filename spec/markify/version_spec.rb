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

describe Markify do

  describe 'VERSION constant' do
    it 'should be a version string' do
      Markify::VERSION.is_a?(String).should == true
    end

    it 'should be consist of three numbers' do
      Markify::VERSION.match(/^(\d+\W)(\d+\W)(\d+)$/).should_not == nil
    end
  end

  describe 'SUMMARY constant' do
    it 'should be a summary string' do
      Markify::SUMMARY.is_a?(String).should == true
    end
  end

  describe 'DESCRIPTION constant' do
    it 'should be a description string' do
      Markify::DESCRIPTION.is_a?(String).should == true
    end
  end

  describe 'NAME constant' do
    it 'should be a name string' do
      Markify::NAME.is_a?(String).should == true
    end
  end
end