# encoding: utf-8

require 'optparse'

module Markify::OptParser

  def self.parse!
    parse
  end

  protected

  def self.parse
    options = {}

    oparser = OptionParser.new do |opts|
      opts.banner = "Usage: #{$0} [options]"

      opts.separator ""
      opts.separator "Optional options:"

      opts.on("-f", "--config-file FILE", "Config file (default: ~/markify/config.yml)") do |file|
        options[:config_file] = Pathname(file)
      end

      opts.on('-n', '--noop', 'No operation, only stout output') do |n|
        options[:noop] = n
      end

      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end

      opts.separator ''
      opts.separator 'Common options:'

      opts.on_tail('--init', 'Create example configuration') do
        if options[:config_file]
          Markify::Settings.create_exmple_config(options[:config_file])
        else
          Markify::Settings.create_example_config
        end
      end

      opts.on_tail('--version', 'Show version inforamtion') do
        puts Markify::LICENCE
        exit
      end

      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
        exit
      end

      if ARGV.size == 0
        puts Markify::DESCRIPTION
        puts
        puts opts
        puts
        puts Markify::LICENCE

        exit
      end
    end.parse!

    options
  end
end