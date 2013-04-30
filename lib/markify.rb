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

require 'date'
require 'digest'
require 'yaml'
require 'pathname'

require "markify/version"
require "markify/database"
require "markify/bot"
require "markify/settings"
require "markify/optparser"
require 'markify/mark'
require 'markify/scraper/base'
require 'markify/scraper/hbrs'

module Markify

  def self.run!
    @options      = Markify::OptParser.parse!
    @config       = Markify::Settings.load!(@options[:config_file])

    if @options[:test]
      Markify::Settings.test_settings(@config)
      exit
    end

    mark_database = Markify::Database.new(@config['general']['database_file'])

    all_marks = Markify::Scraper::Hbrs.new(@config['sis']['login_name'], @config['sis']['login_password']).scrape!
    new_marks = mark_database.check_for_new_marks(all_marks)

    if new_marks.count == 0 && (@config['general']['verbose'] || @options[:noop])
      puts "No new marks."
      exit
    end

    bot = Markify::Bot.new(@config['xmpp']['bot_id'], @config['xmpp']['bot_password']) if @options[:send]

    new_marks.sort_by{|mark| mark.date}.each do |mark|
      unless @options[:noop]
        mark_database.write_checksum(mark.hash)
      end

      bot.send_message(@config['xmpp']['recipients'], mark.to_s) if @options[:send]

      puts mark.to_s if @config['general']['verbose'] || @options[:verbose]
    end
  end
end