require 'date'
require 'digest'
require 'yaml'
require 'pathname'

require "markify/version"
require "markify/scraper"
require "markify/database"
require "markify/bot"
require "markify/settings"
require "markify/optparser"

class Markify

  attr_reader :config, :options

  def initialize
    @options      = Markify::OptParser.parse!
    @config       = Markify::Settings.load!(options[:config_file])
    mark_database = Markify::Database.new

    all_marks = Markify::Scraper.new(@config['sis']['login_name'], @config['sis']['login_password']).marks
    new_marks = mark_database.check_for_new_marks(all_marks)

    if new_marks.count == 0 && (@config['general']['verbose'] || @options[:noop])
      puts "No new marks."
      exit
    end

    bot = Markify::Bot.new(@config['xmpp']['bot_id'], @config['xmpp']['bot_password']) unless @options[:noop]

    new_marks.sort_by{|mark| mark.date}.each do |mark|
      unless @options[:noop]
        bot.send_message(@config['xmpp']['recipients'], mark.to_s)
        mark_database.write_checksum(mark.hash)
      end

      puts mark.to_s if @config['general']['verbose'] || @options[:verbose]
    end
  end
end