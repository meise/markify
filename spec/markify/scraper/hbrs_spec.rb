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
end