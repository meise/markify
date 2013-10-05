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

require 'spec_helper'

describe Markify::Settings do

  before(:each) do
    @gem_root = File.expand_path('../../..', __FILE__)
    @config_file_path = Pathname(@gem_root) + 'examples/config.yml.example'
    @example_config_path = Pathname(@gem_root) + 'tmp/config.yml'

    @example_config = Pathname(@gem_root) + 'tmp/config.yml.example'
    File.open(@example_config, 'a+', 0600) do |file|
      file.puts <<CONTENT
xmpp:
  recipients: 'bla@jabber.foo.baz'

general:
  database_file: "#{@config_file_path}"
CONTENT
    end
  end

  after(:each) do
    Dir[ @example_config_path.dirname + '**/*' ].each do |file|
      File.delete(file)
    end
  end

  describe '.load!' do
    it 'should be validate after loading' do
      Markify::Settings.load!( file = @config_file_path ).should be_an_instance_of Hash
    end

    it 'should terminate and print a warning when no config can be load' do
      expect {

        capture_stdout {
          Markify::Settings.load!( file = @config_file_path + "no_config" )
        }.should match /Config file does not exist./

      }.to raise_error SystemExit
    end

    it 'should be load a configuration' do
      Markify::Settings.load!( file = @config_file_path )['general']['verbose'].should eq false
    end

    it 'should fix path data types' do
      Markify::Settings.load!( file = @config_file_path )['general']['database_file'].should be_an_instance_of Pathname
    end
  end

  describe '.validate' do
    it 'should take care about the recipient data type' do
      Markify::Settings.load!( file = @config_file_path )['xmpp']['recipients'].should be_an_instance_of Array
    end

    it 'should take care that the string data type for xmpp recipients is changed to an array' do
      Markify::Settings.load!( file = @example_config )['xmpp']['recipients'].should be_an_instance_of Array
    end
  end

  describe '.create_example_config' do
    it 'should be terminate and print a message if a file exist' do
      expect {

        capture_stdout {
          Markify::Settings.create_example_config( file = @config_file_path )
        }.should match /already exists/

      }.to raise_error SystemExit
    end

    it 'should create example config to a given file path' do
      expect {
        capture_stdout {
          Markify::Settings.create_example_config( file = @example_config_path )
        }.should match /created/

      }.to raise_error SystemExit

      File.exist?(@example_config_path).should be true
    end

    it 'should create config with permissions 600' do
      $stdout = fake = StringIO.new # ignore stdout messanges

      expect {
        Markify::Settings.create_example_config( file = @example_config_path )
      }.to raise_error SystemExit

      @example_config_path.stat.inspect.should match /mode=0100600/
    end
  end
end