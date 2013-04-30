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

require 'mechanize'

module Markify::Scraper
  class Base

    attr_reader :marks

    def initialize(login_name, login_password, sis_login_page)
      @agent = Mechanize.new
      original, library = */(.*) \(.*\)$/.match(@agent.user_agent)
      @agent.user_agent =
          "#{Markify::NAME.capitalize}/#{Markify::VERSION} #{library} (https://github.com/meise/markify)"

      @data                  = {}
      @data[:login_page]     = sis_login_page
      @data[:login_name]     = login_name
      @data[:login_password] = login_password

      @marks = []
    end

    def scrape!
      scrape
    end

    def test_login
      puts 'Scraper: Nothing to test.'
    end
  end
end