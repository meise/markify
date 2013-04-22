# encoding: utf-8

module Markify::Settings

  DEFAULT_CONFIG_PATH = Pathname(ENV['HOME'] + "/markify/config.yml")

  attr_reader :config

  def self.load!(file = nil)
    config_file = file || DEFAULT_CONFIG_PATH

    if config_file.exist?
      YAML::load_file(config_file)
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

  recipients: bla@jabber.foo.baz, müp@möp.blap.ba

general:
  verbose: false

database:
  hashes: "#{ENV['HOME'] + '/markify/hashes.txt'}"
CONTENT
      end

      puts "#{config_file} created."

      exit
    end
  end
end