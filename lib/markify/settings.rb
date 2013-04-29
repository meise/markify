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

module Markify::Settings

  DEFAULT_CONFIG_PATH = Pathname(ENV['HOME'] + "/markify/config.yml")

  attr_reader :config

  def self.load!(file = nil)
    config_file = file || DEFAULT_CONFIG_PATH

    if config_file.exist?
      config = YAML::load_file(config_file)
      validate(config)
    else
      puts 'Config file does not exist. Please create it.'
      puts "  $ #{$0} --init"
      exit
    end
  end

  def self.create_example_config(file = nil)
    config_file = file || DEFAULT_CONFIG_PATH

    if config_file.exist?
      puts "Configuration file #{config_file} already exists."
      exit
    else
      Dir.mkdir(config_file.dirname) unless config_file.dirname.exist?

      File.open(config_file, 'a+', 0600) do |file|
        file.puts <<CONTENT
sis:
  login_name: "foobaz2s"
  login_password: "fnord2000"

xmpp:
  bot_id: "bot@foo.baz.er"
  bot_password: "möpmöp"

  recipients: [bla@jabber.foo.baz, müp@möp.blap.ba]

general:
  verbose: false
  database_file: "#{ENV['HOME'] + '/markify/hashes.txt'}"
CONTENT
      end

      puts "#{config_file} created."

      exit
    end
  end

  def self.test_settings(config)
    Markify::Scraper.new(config['sis']['login_name'], config['sis']['login_password']).test_login

    begin
      Markify::Bot.new(config['xmpp']['bot_id'],
                     config['xmpp']['bot_password']).send_message(config['xmpp']['recipients'],
                                                                 "#{Markify::NAME} Test #{Time.now}")
    rescue Jabber::ClientAuthenticationFailure
      puts "XMPP: Bot authentication failed."
    else
      puts "XMPP: Bot works."
    end
  end

  protected

  def self.validate(config)
    # convert recipients to an array
    if config['xmpp']['recipients'].is_a?(String)
      config['xmpp']['recipients'] = [ config['xmpp']['recipients'] ]
    end

    unless config['general']['database_file'].nil?
      config['general']['database_file'] = Pathname(config['general']['database_file'])
    end

    config
  end
end