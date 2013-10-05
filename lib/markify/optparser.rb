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

require 'optparse'

module Markify::OptParser

  def self.parse!(argv = nil || ARGV)
    @argv = argv
    parse
  end

  protected

  def self.parse
    options = {}

    oparser = OptionParser.new do |opts|
      opts.banner = "Usage: #{$0} [options]"

      opts.separator ""
      opts.separator "Optional options:"

      opts.on('-s', '--send', 'Send XMPP messages') do |s|
        options[:send] = s
      end

      opts.on('-n', '--noop', 'No operation, only stdout output') do |n|
        options[:noop] = n
      end

      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end

      opts.separator ""

      opts.on("-f", "--config-file FILE", "Config file (default: ~/markify/config.yml)") do |file|
        options[:config_file] = Pathname(file)
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

      opts.on_tail('--test', 'Test configuration and accounts') do
        options[:test] = true
      end

      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
        exit
      end

      opts.on_tail('--version', 'Show version information') do
        puts Markify::LICENCE
        exit
      end

      if @argv.size == 0
        puts Markify::DESCRIPTION
        puts
        puts opts
        puts
        puts Markify::LICENCE

        exit
      end
    end.parse!(@argv)

    options
  end
end