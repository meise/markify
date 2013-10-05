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

describe Markify::Scraper::Hbrs do
  before do
    @scraper_hbrs = Markify::Scraper::Hbrs.new("foobar", "möp")
  end

  describe '#initialize' do
    it 'should create an scraper object for hbrs university' do
      pending
    end
  end

  describe '#test_login' do
    it 'should return a string when password or username is wrong' do
      pending
    end

    it 'should return a string when login works' do
      pending
    end
  end

  context 'protected' do
    describe '#get_marks' do
      it 'should return a array with marks' do
        pending
      end

      it 'should pass the right columns into mark objects' do
        pending
      end

      it 'should ignore rows without an id consist of 4-5 numbers' do
        pending
      end

      it "should ignore passed status AN for 'angemeldet'" do
        pending
      end
    end

    describe '#get_marks_table' do
      it 'should return a mechanize html table' do
        pending
      end

      it 'should terminate if the right table is not found' do
        pending
      end
    end

    describe '#sis_login' do
      it 'should return a mechanize page' do
        pending
      end
    end
  end

end