# encoding: UTF-8
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

describe Markify::Scraper::Base do

  before(:each) do
    @scraper = Markify::Scraper::Base.new('foobar', 'möp', 'http://foobar.baz')
  end

  describe '#initialize' do
    it 'should set login name' do
      @scraper.instance_variable_get(:@data)[:login_name].should match 'foobar'
    end

    it 'should set login password' do
      @scraper.instance_variable_get(:@data)[:login_password].should match 'möp'
    end

    it 'should set sis login page' do
      @scraper.instance_variable_get(:@data)[:login_page].should match 'http://foobar.baz'
    end

    it 'should have an empty marks array by default' do
      @scraper.marks.should be_empty
    end
  end

  describe '@marks' do
    it 'should be not writable from outside' do
      expect {
        @scraper.marks = %w{1 2 3}
      }.to raise_error(NoMethodError)
    end

    it 'should be readable from outside' do
      @scraper.instance_variable_set(:@marks, %w{23 42})

      @scraper.marks.count.should eq 2
      @scraper.marks.first.should match /23/
      @scraper.marks.last.should match /42/
    end

    it 'should be a array' do
      @scraper.instance_variable_get(:@marks).should be_an_instance_of Array
    end
  end
end