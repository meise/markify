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

describe Markify::OptParser do

  before(:each) do
    @original_stdout = $stdout
    ARGV.clear

    @gem_root = File.expand_path('../../..', __FILE__)
    @config_file_path = Pathname(@gem_root) + 'examples/config.yml.example'
  end

  after(:each) do
    $stdout = @original_stdout
  end

  describe '.parse!' do
    it 'should start command line parsing' do
      capture_stdout {
        expect { Markify::OptParser.parse!  }.to raise_error SystemExit
      }
    end
  end

  context 'protected' do
    describe '.parse' do
      it 'should return an options hash' do
        [ ['-s'], ['-v'] ].each do |argv|
          Markify::OptParser.parse!( argv ).should be_an_instance_of Hash
        end
      end

      it 'should exit if version [--version] flag is set' do
        argv = ['--version']

        output = capture_stdout {
          expect { Markify::OptParser.parse!(argv) }.to raise_error SystemExit
        }

        output.should match /Released under/
      end

      it 'should print help message if [-h] or [--help] flag is set and exit after printing ' do
        [ ['--help'], ['-h'] ].each do |argv|
          output = capture_stdout {
            expect { Markify::OptParser.parse!(argv)  }.to raise_error SystemExit
          }

          output.should match /Usage:/
        end
      end

      it 'should print description, help and licence if program is called without options' do
        argv = []

        output = capture_stdout {
          expect { Markify::OptParser.parse!(argv) }.to raise_error SystemExit
        }

        output.should match /Released under /
      end

      it 'should set config file with [-f] or [--config-file] option' do
        [ ['-v', '-f', "#{@config_file_path}"], ['-v', '--config-file', "#{@config_file_path}"] ].each do |argv|
          Markify::OptParser.parse!( argv )[:config_file].to_s.should match "#{@config_file_path}"
        end
      end

      it 'should be use a pathname object for config file path' do
        [ ['-v', '-f', "#{@config_file_path}"], ['-v', '--config-file', "#{@config_file_path}"] ].each do |argv|
          Markify::OptParser.parse!( argv )[:config_file].should be_an_instance_of Pathname
        end
      end

      it 'should set verbose option with [-v] or [--verbose]' do
        [ ['-v'], ['--verbose'] ].each do |argv|
          Markify::OptParser.parse!( argv )[:verbose].should be true
        end
      end

      it 'should set no operation option with [-n] or [--noop]' do
        [ ['-n'], ['--noop'] ].each do |argv|
          Markify::OptParser.parse!( argv )[:noop].should be true
        end
      end

      it 'should set send xmpp message with option [-s] ot [--send]' do
        [ ['-s'], ['--send'] ].each do |argv|
          Markify::OptParser.parse!( argv )[:send].should be true
        end
      end

      it 'should set test option if [--test] is defined' do
        Markify::OptParser.parse!( ['--test'] )[:test].should be true
      end
    end
  end
end