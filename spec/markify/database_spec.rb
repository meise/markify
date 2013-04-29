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

describe Markify::Database do
  before(:each) do
    File.open(Pathname('/tmp/markify_hashes.txt'), "a+") do |file|
      file.puts <<HASHES
# markify hash database
19189e4668008cd48265538054282379c38bc7422811e4402a7f1e693138a579
0482652650dc959dbaa199f7f08d60b1184c4329a41152479ecec7835cd2c9c5
HASHES
    end

    @database = Markify::Database.new(Pathname('/tmp/markify_hashes.txt'))
  end

  after(:each) do
    @database.file_path.delete
  end

  it "should set default database path" do
    @database.file_path.should_not eq(nil)
  end

  it "should set database path" do
    @database.file_path.should eq(Pathname('/tmp/markify_hashes.txt'))
  end

  describe "#check_for_new_marks" do
    it "should return a array with only new marks" do
      mark1 = Markify::Mark.new('Peter Lustig', '2342', '3.0', 'BE', '2', '23.02.1942')
      mark2 = Markify::Mark.new('Peter Lustig', '4223', '1.7', 'BE', '3', '23.02.1923')
      mark3 = Markify::Mark.new('Peter Lustig', '2323', '5.0', 'NB', '1', '24.09.1923')

      @database.check_for_new_marks([mark1, mark2, mark3]).should eq([mark3])
    end
  end

  describe "#checksums" do
    it "should return all checksums in database" do
      @database.checksums.should eq(['19189e4668008cd48265538054282379c38bc7422811e4402a7f1e693138a579',
                                     '0482652650dc959dbaa199f7f08d60b1184c4329a41152479ecec7835cd2c9c5'])
    end
  end

  describe "#read_checksums" do
    it "should be protected" do
      @database.protected_methods.include?(:read_checksum_file).should eq(true)
    end

    it "should hash file and return array for each line" do
      @database.send(:read_checksum_file,
                     *Markify::Database.protected_methods).should eq(['# markify hash database',
                                                                      '19189e4668008cd48265538054282379c38bc7422811e4402a7f1e693138a579',
                                                                      '0482652650dc959dbaa199f7f08d60b1184c4329a41152479ecec7835cd2c9c5'])
    end
  end

  describe "#create_checksum_file" do
    it "should be protected" do
      @database.protected_methods.include?(:create_checksum_file).should eq(true)
    end

    it "should create new hash database if no exist" do
      # TODO
    end
  end
end